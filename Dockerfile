# Use an official PHP 8.2 image as a base
FROM php:8.2-fpm

# Set the working directory to /app
WORKDIR /app

# Install Composer from the official Composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install dependencies required for Laravel
RUN apt-get update && apt-get install -y libzip-dev zip unzip libfreetype6-dev libjpeg62-turbo-dev libpng-dev libxml2-dev libcurl4-openssl-dev libssl-dev

# Install PHP extensions required for Laravel
RUN docker-php-ext-install zip
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-install curl
RUN docker-php-ext-install xml

# Install MongoDB PHP extension
RUN pecl install mongodb
RUN docker-php-ext-enable mongodb

# Copy the application code
COPY . .

# Expose port 9000 to the docker host
EXPOSE 9000

# Start the FPM server
CMD ["php-fpm"]
