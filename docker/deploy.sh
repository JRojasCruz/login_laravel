#!/bin/sh

echo "Cachando configuración..."
php artisan config:cache

echo "Cachando rutas..."
php artisan route:cache

echo "Ejecutando migraciones..."
php artisan migrate --force