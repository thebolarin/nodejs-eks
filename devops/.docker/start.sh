#!/bin/bash

set -e

role=${CONTAINER_ROLE:-app}
env=${APP_ENV:-production}

# if [ "$env" != "local" ]; then
#     echo "Caching configuration..."
#     (cd /srv/app && php artisan config:cache && php artisan route:cache && php artisan view:cache && php artisan event:cache)
# fi

if [ "$role" = "app" ]; then
    npm run start:prod

elif [ "$role" = "db-migrator" ]; then

    echo "Running the database migration..." 
    npm run migrate

elif [ "$role" = "pub-sub" ]; then

    echo "Running pub-sub consumer..." 
    npm run kafka:consume

else
    echo "Could not match the container role \"$role\""
    exit 1
fi
