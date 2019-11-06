#!/usr/bin/env bash

# Source the configs.
source /usr/src/app/.env

# Creates an env variable that is utilized to authenticate and make modifications within the MS SQL Database.
export querydb="sqlcmd -S localhost -U sa -P ${DB_PASSWORD}" && \


sql_counter=1
while [ $sql_counter -le 60 ]
do
    TEMP_VAR=$(sqlcmd -S localhost -U sa -P "$DB_PASSWORD" -i /usr/src/app/database_scripts/waitForSqlServer.sql | grep '1\|0' | cut -d'(' -f1)
    echo "Attempting to connect to SQL. Attempt number $sql_counter"
    if [ $TEMP_VAR = "1" ]
    then
        echo "Successfully connected to SQL..."
        break;
    fi
    if (( $sql_counter == 60 ))
    then
        echo "Failed to connected to SQL after $sql_counter attempts! Please verify your config file values are set correctly."
        exit 1;
    fi
    echo "SQL unavailable..."
    ((sql_counter++))
    sleep 1
done && \


# Run the setup script to create the MS SQL Database.
echo "Creating MS SQL Schema..." && \
$querydb -i /usr/src/app/database_scripts/createDatabase.sql && \


# Populates the MS SQL Database with mock data.
echo "Inserting Mock Data..." && \
$querydb -i /usr/src/app/database_scripts/insertMockData.sql && \


# Creates foreign key associations within mock MS SQL Database.
echo "Creating Foreign Key References..." && \
$querydb -i /usr/src/app/database_scripts/createForeignKeyReferences.sql && \


# Enables Change Tracking within mock MS SQL Database.
echo "Enabling Change Tracking..." && \
$querydb -i /usr/src/app/database_scripts/enableChangeTracking.sql && \


# Enables Snapshot Retention within mock MS SQL Database.
echo "Enabling Snapshot Retention..." && \
$querydb -i /usr/src/app/database_scripts/enableSnapshotRetention.sql && \


# Creates stored procedures by iterating through every stored procedure script in database_scripts/stored_procedures.
echo "Creating Stored Procedures..." && \
for storedProcedure in /usr/src/app/database_scripts/stored_procedures/*.sql;do $querydb -i "$storedProcedure";done

# Cleanup job used to removed unneeded files after image has been successfully created and populated.
echo "Cleaning up environment..." && \
. /usr/src/app/cleanup.sh
