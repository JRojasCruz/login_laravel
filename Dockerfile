FROM php:8.3-fpm-alpine

# Actualizamos e instalamos dependencias necesarias
RUN apk update && \
    apk add --no-cache \
    postgresql-libs \
    postgresql-dev \
    build-base \
    nginx

# Instalamos extensiones PHP
RUN docker-php-ext-install pdo pdo_mysql pgsql

# Directorio de trabajo
WORKDIR /var/www/html

# Copiamos el proyecto
COPY . .

# Instalamos Composer
RUN curl -sS https://getcomposer.org/installer  | php -- --install-dir=/usr/local/bin --filename=composer

# Instalamos dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Damos permisos a carpetas importantes
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copiamos la configuración de Nginx
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/default.conf /etc/nginx/conf.d/default.conf

# Exponemos el puerto 80 (el usado por Nginx)
EXPOSE 80

# Iniciamos servicios al levantar el contenedor
CMD service nginx start && php-fpm -F