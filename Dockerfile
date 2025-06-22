# Usamos una imagen base con PHP y Nginx
FROM php:8.3-fpm-alpine

# Instalamos dependencias necesarias
RUN docker-php-ext-install pdo pdo_mysql pgsql

# Instalamos Composer
RUN curl -sS https://getcomposer.org/installer  | php -- --install-dir=/usr/local/bin --filename=composer

# Directorio de trabajo
WORKDIR /var/www/html

# Copiamos el código del proyecto
COPY . .

# Instalamos dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Damos permisos a las carpetas usadas por Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Iniciamos PHP-FPM
CMD ["php-fpm"]