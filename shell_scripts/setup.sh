#!/usr/bin/env bash
# Wait for the SQL Server to launch.
sleep 10s

# Source the configs.
source /usr/src/app/.env

# Creates an env variable that is utilized to authenticate and make modifications within the MS SQL Database.
export querydb="sqlcmd -S localhost -U sa -P ${DB_PASSWORD}" && \


# Run the setup script to create the MS SQL Database.
echo "Creating MS SQL Schema..." && \
$querydb -i /usr/src/app/database_scripts/createDatabase.sql && \


# Populates the MS SQL Database with mock data.
sleep 3s
echo "Inserting Mock Data..." && \
$querydb -i /usr/src/app/database_scripts/insertMockData.sql && \


# Creates foreign key associations within mock MS SQL Database.
sleep 3s
echo "Creating Foreign Key References..." && \
$querydb -i /usr/src/app/database_scripts/createForeignKeyReferences.sql && \


# Enables Change Tracking within mock MS SQL Database.
sleep 3s
echo "Enabling Change Tracking..." && \
$querydb -i /usr/src/app/database_scripts/enableChangeTracking.sql && \


# Enables Snapshot Retention within mock MS SQL Database.
echo "Enabling Snapshot Retention..." && \
$querydb -i /usr/src/app/database_scripts/enableSnapshotRetention.sql && \


# Creates stored procedures by iterating through every stored procedure script in database_scripts/stored_procedures.
echo "Creating Stored Procedures..." && \
for storedProcedure in /usr/src/app/database_scripts/stored_procedures/*.sql;do $querydb -i "$storedProcedure";done && \


# Cleanup job used to removed unneeded files after image has been successfully created and populated.
echo "Cleaning up environment..." && \
. /usr/src/app/cleanup.sh
