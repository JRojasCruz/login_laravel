#!/bin/sh

# Limpiar caché previa (opcional)
rm -rf /var/www/html/bootstrap/cache/*.php

# Generar nuevamente la caché de configuración
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Aseguramos permisos
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Iniciar servicios
nginx && php-fpm -F