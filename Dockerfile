FROM php:7.4-apache AS skyoj

SHELL ["/bin/bash", "-c"]
WORKDIR /var/www/html
COPY . /var/www/html

# Install required PHP extensions and system dependencies
RUN apt-get update && apt-get install -y \
    libgmp-dev \
    git \
    unzip \
    mariadb-client \
    mariadb-server
RUN docker-php-ext-install pdo pdo_mysql gmp

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install

# Set up the database
RUN service mariadb start && mysql -e "CREATE DATABASE sky;" \
    && mysql -e "CREATE USER 'skyuser'@'localhost' IDENTIFIED BY 'skypassword';" \
    && mysql -e "GRANT ALL PRIVILEGES ON sky.* TO 'skyuser'@'localhost';" \
    && mysql -e "FLUSH PRIVILEGES;"

# Run database migrations
RUN service mariadb start && ./vendor/bin/phinx m

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["service mariadb start && apache2-foreground"]
