#!/usr/bin/env bash
create_env_file() {
    if [ $# -ne 1 ]; then
        echo "ERROR: Expected 1 argument, but $# were provided. Exiting."
        echo "\n 
        Admin Password: <parameter 1> \n"
        return
    else
        echo "Creating new .env file!"
        tee ".env" <<-TEXT >/dev/null
DB_PASSWORD=$1
TEXT
    fi
}