FROM php:7.4-apache

RUN pecl install mongodb && docker-php-ext-enable mongodb

RUN apt-get update && apt-get install -y git zip unzip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

 


WORKDIR /var/www/html

COPY . /var/www/html/

RUN composer install --no-dev

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

RUN a2enmod rewrite
CMD ["apache2ctl", "-DFOREGROUND"]

EXPOSE 80
