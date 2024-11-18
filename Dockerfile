# Use an official PHP 8.2 image as the base
FROM php:8.2-fpm

# Set the working directory to /app
WORKDIR /app

# Copy the composer.lock and composer.json files
COPY composer.lock composer.json ./

# Install the dependencies
RUN composer install --no-dev --prefer-dist

# Copy the rest of the application code
COPY . .

# Expose the port
EXPOSE 9000

# Run the command to start the PHP-FPM server
CMD ["php-fpm"]
