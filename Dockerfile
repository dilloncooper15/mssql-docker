# Run Latest Linux image SQL Server from Microsoft.
FROM mcr.microsoft.com/mssql/server

# Change current working directory.
WORKDIR /usr/src/app

# Update packages, install curl, node/npm, & tedious
RUN apt-get -y update  && \
        apt-get install -y curl && \
        curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
        apt-get install -y nodejs && \
        npm install tedious

# Update packages, install curl, node/npm, tedious.
RUN apt-get -y update

# Bundle app source.
COPY . .

# Grant permissions for the import-data script to be executable.
RUN chmod +x /usr/src/app/shell_scripts/setup.sh

#Set path for SQLCMD.
ENV PATH "$PATH:/opt/mssql-tools/bin/"

# Expose container's port 8080.
EXPOSE 8080

# Execute shell script, setup.sh, and launch SQL Server in the background.
CMD [ "bash", "-c", "./shell_scripts/setup.sh & /opt/mssql/bin/sqlservr" ]
