SKY Online Judge (Developing)
=================
>An open source online judge web system 

Required
-------------
1. Docker & Docker-Compose

Install
-------------
1. Clone SKY Online Judge Repository to yout website (Don't forget to fetch submodules)
2. Copy `config/config.example.php` to `config/config.php`
3. Fill out your MySQL setting in config.php
4. Copy `LocalSetting.example.php` to `LocalSetting.php` then set its starting directory at `$_E['SITEDIR']`
5. Run `docker compose up --watch` to start the system
6. Open your web browser and go to `http://localhost:9499` to access the SKY Online Judge system.

```bash
# This uses default setting.
git clone --recurse-submodules git@github.com:yushiuan9499/SkyOnlinejudge.git
cd SkyOnlinejudge
git checkout support-docker

cp config/config.example.php config/config.php
cp LocalSetting.example.php LocalSetting.php

docker compose up --watch
```

Customization
-------------
- If you want to change the port, you should modify the `docker-compose.yml` and `$_E['SITEPORT']` in `GlobalSetting.php` file. Make sure the port number are consistent.
- If you want to change database settings, you should modify `config/config.php` and `docker-compose.yml` file. Make sure the settings are consistent.
