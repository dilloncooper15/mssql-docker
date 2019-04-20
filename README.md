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
