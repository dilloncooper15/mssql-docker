#!/usr/bin/env bash
create_env_file() {
    if [ $# -ne 1 ]; then 
        echo "ERROR: Please provide a password for the database."
        return
    else
        echo "Creating new .env file!"
        tee ".env" <<-TEXT >/dev/null
DB_PASSWORD=$1
TEXT
    fi
}