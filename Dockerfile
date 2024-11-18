# Use the official PHP 8.2 image as a base
FROM php:8.2-fpm

# Set the working directory to /app
WORKDIR /app

# Copy the composer.lock and composer.json files into the container
COPY composer.lock composer.json ./

# Install the dependencies
RUN apt-get update && apt-get install -y libzip-dev zip
RUN docker-php-ext-install zip
RUN composer install --no-dev --prefer-dist

# Copy the rest of the application code into the container
COPY . .

# Install the required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql
RUN pecl install mongodb
RUN docker-php-ext-enable mongodb

# Set the environment variables
ENV COMPOSER_HOME app/composer
ENV COMPOSER_CACHE_DIR app/composer/cache

# Expose the port
EXPOSE 8000

# Run the command to start the FPM server
CMD ["php-fpm"]
