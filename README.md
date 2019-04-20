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
2. `create_env_file "<INSERT PASSWORD HERE>"`

# Creating the database within a Docker container
To create and run the database image inside of a Docker container, confirm you have Docker already installed on your computer and port `8080` is not already allocated to another program. Then, run the following command: `docker-compose down && docker-compose up -d --build;`


# Running published image locally
1. `docker run -d -p 1433:1433 -p 8080:8080 --name <INSERT DESIRED CONTAINER NAME> <INSERT DOCKER IMAGE FROM REGISTRY HERE>;`
2. `docker exec -it <INSERT DESIRED CONTAINER NAME> bash`
3. `sqlcmd -S localhost -U sa -P <PASSWORD SET IN .env FILE>`
4. 
    1> `USE <INSERT DATABASE NAME HERE>`
    2> `SELECT * FROM <INSERT DESIRED TABLE NAME>`
    3> `GO`
OR 
    1> `SELECT * FROM <INSERT DATABASE NAME HERE>.dbo.<INSERT DESIRED TABLE NAME>;`
    2> `go`

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
OR 
    1> `SELECT * FROM ExampleDb.dbo.Customer;`
    2> `GO`
