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
In order to authenticate with the database, you will need to create a `.env` file by executing the following steps:
0. Navigate to the project's directory.
1. `. ./shell_scripts/create_env_variables.sh`
2. `create_env_file <INSERT PASSWORD HERE>`


# Creating the database within a Docker container
To create and run the database image inside of a Docker container, confirm you have Docker already installed on your computer and port `8080` is not already allocated to another program. Then, run the following command: `docker-compose down && docker-compose up -d;`


# Running published image locally
Please note, if you have a `build` step in your `Dockerfile`, and you wish to consume an image from a repository (i.e. Docker Hub or GitLab Registry), you will have to have the image pulled already or, if you do not have it pulled down already, simply perform a `docker pull <INSERT DOCKER IMAGE FROM REPOSITORY HERE>` before executing `docker-compose up`. If you do not have the image pulled down before running `docker-compose up`, the build stage, within your `docker-compose.yml`, will take precedence, resulting in an image being created from your local `Dockerfile` and not the remote image. 
1. `docker run -d -p 1433:1433 -p 8080:8080 --name <INSERT DESIRED CONTAINER NAME> <INSERT DOCKER IMAGE FROM REPOSITORY HERE>;`
2. `docker exec -it <INSERT DESIRED CONTAINER NAME> bash`
3. `sqlcmd -S localhost -U sa -P <INSERT PASSWORD SET IN .env FILE>`
4. 
    1> `USE <INSERT DATABASE NAME HERE>`
    2> `SELECT * FROM <INSERT DESIRED TABLE NAME>`
    3> `GO`
*OR* 
    1> `SELECT * FROM <INSERT DATABASE NAME HERE>.dbo.<INSERT DESIRED TABLE NAME>;`
    2> `go`
If you wish not to perform a query by exec'ing into the container, you can open `Azure Data Studio` or `SQL Server Management Studio`, and connect to the database by passing in the following:
1. Connection type: `Microsoft SQL Server`
2. Server: `localhost`
3. Authentication type: `SQL Login`
4. User name: `sa`
5. Password: `<INSERT PASSWORD SET IN .env FILE>`
6. Database: `<INSERT NAME OF DATABASE HERE>` (Optionally, you can leave this set to `<Default>`, if you wish).

**FOR EXAMPLE**: 
1. `docker run -d -p 1433:1433 -p 8080:8080 --name mssql registry.gitlab.com/dillonc/mssql-docker:75b8e40f;`
2. `docker exec -it mssql bash`
3. `sqlcmd -S localhost -U sa -P SuperSecretPassword123`
NOTE: You can also create an environment variable and call it: `export querydb="sqlcmd -S localhost -U sa -P SuperSecretPassword123" && $querydb`.
This is equivalent to the command outlined in `step 3`.
4. 
    1> `USE ExampleDb`
    2> `SELECT * FROM Customer`
    3> `GO`
*OR* 
    1> `SELECT * FROM ExampleDb.dbo.Customer;`
    2> `GO`
Connection through `Azure Data Studio`:
1. Connection type: `Microsoft SQL Server`
2. Server: `localhost`
3. Authentication type: `SQL Login`
4. User name: `sa`
5. Password: `SuperSecretPassword123`
6. Database: `ExampleDb`
