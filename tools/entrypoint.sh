#!/bin/bash
set -e

DB_HOST=db
DB_USER=skyuser
DB_PASSWORD=skypassword

# 等待資料庫連線成功
until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "select 1;" >/dev/null 2>&1; do
    echo "Waiting for database..."
    sleep 2
done

# 執行 migration
./vendor/bin/phinx m

# 啟動 apache
exec apache2-foreground
