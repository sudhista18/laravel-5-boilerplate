FROM phpstorm/php-73-apache-xdebug-27
RUN apt update && apt install unzip -y
ADD bahan.zip /var/phpunit/
WORKDIR /var/phpunit
RUN unzip -o bahan.zip
CMD php artisan serve --port=8080
