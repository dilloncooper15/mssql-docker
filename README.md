<p align="center">
    <img src="https://travis-ci.com/dilloncooper15/mssql-docker.svg?branch=master"></a>
    <img src="https://img.shields.io/github/last-commit/dilloncooper15/mssql-docker.svg"></a>
    <img src="https://coveralls.io/repos/github/dilloncooper15/mssql-docker/badge.svg?branch=master"></a>
    <img src="https://img.shields.io/github/repo-size/dilloncooper15/mssql-docker.svg?branch=master"></a>
    <img src="https://img.shields.io/docker/pulls/velveetacheese/mssql-docker.svg"></a>
    <img src="https://img.shields.io/docker/stars/velveetacheese/mssql-docker.svg"></a>
    <a href="https://twitter.com/intent/follow?screen_name=Cooperdillon777">
        <img src="https://img.shields.io/twitter/follow/Cooperdillon777.svg?style=social&logo=twitter"
            alt="follow on Twitter"></a>
</p>



# Generating .env file
In order to authenticate with the database, you will need to create a `.env` file by executing the following steps: <br>
1. Navigate to the project's directory.
2. `. ./shell_scripts/create_env_variables.sh`
3. `create_env_file <INSERT PASSWORD HERE>`


# Running MS SQL Server image from local build
To create and run the database image inside of a Docker container, confirm you have Docker already installed on your computer and port `8080` is not already allocated to another program. Then, run the following command: `docker-compose -f docker-compose.prod.yml up -d --build;;`


# Running MS SQL Server image from remote repository image
Please note, `docker-compose.yml` will build the latest image pushed to the GitLab Repository. If you want to target a specific build, simply change the image's value.
1. `docker-compose up -d --build;`
2. `docker exec -it <INSERT DESIRED CONTAINER NAME> bash`
3. `sqlcmd -S localhost -U sa -P <INSERT PASSWORD SET IN .env FILE>`
4. Then, run the following three commands to query a table in your database: <br>
> 1. `USE <INSERT DATABASE NAME HERE>`<br>
> 2. `SELECT * FROM <INSERT DESIRED TABLE NAME>` <br>
> 3. `GO` <br>

*OR* <br>
> 1. `SELECT * FROM <INSERT DATABASE NAME HERE>.dbo.<INSERT DESIRED TABLE NAME>;` <br>
> 2. `go` <br>

If you wish not to perform a query by exec'ing into the container, you can open `Azure Data Studio` or `SQL Server Management Studio`, and connect to the database by passing in the following:
1. Connection type: `Microsoft SQL Server`
2. Server: `localhost`
3. Authentication type: `SQL Login`
4. User name: `sa`
5. Password: `<INSERT PASSWORD SET IN .env FILE>`
6. Database: `<INSERT NAME OF DATABASE HERE>` (Optionally, you can leave this set to `<Default>`, if you wish).

**FOR EXAMPLE**: 
1. `docker-compose up -d --build`
2. `docker exec -it mssql bash`
3. `sqlcmd -S localhost -U sa -P SuperSecretPassword123`
NOTE: You can also create an environment variable and call it: `export querydb="sqlcmd -S localhost -U sa -P SuperSecretPassword123" && $querydb`.
This is equivalent to the command outlined in `step 3`.
4. 
> 1. `USE ExampleDb` <br>
> 2. `SELECT * FROM Customer` <br>
> 3. `GO` <br>

*OR* <br>
> 1. `SELECT * FROM ExampleDb.dbo.Customer;` <br>
> 2. `GO` <br>

**Connection through `Azure Data Studio`**:
1. Connection type: `Microsoft SQL Server`
2. Server: `localhost`
3. Authentication type: `SQL Login`
4. User name: `sa`
5. Password: `SuperSecretPassword123`
6. Database: `ExampleDb`
