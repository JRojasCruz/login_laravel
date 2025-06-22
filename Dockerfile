FROM php:8.3-fpm-alpine

# Instalamos dependencias necesarias
RUN apk update && \
    apk add --no-cache postgresql-libs postgresql-dev build-base

# Instalamos extensiones PHP
RUN docker-php-ext-install pdo pdo_mysql pgsql

# Directorio de trabajo
WORKDIR /var/www/html

# Copiamos el proyecto
COPY . .

# Instalamos Composer
RUN curl -sS https://getcomposer.org/installer  | php -- --install-dir=/usr/local/bin --filename=composer

# Instalamos dependencias
RUN composer install --no-dev --optimize-autoloader

# Permisos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Iniciamos PHP-FPM
CMD ["php-fpm"]