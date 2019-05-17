FROM centos:7
RUN yum install sudo yum-utils git make gcc-c++ curl unzip epel-release -y && \
    rpm -i https://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager repos --enable remi-php73 && \
    yum install php php-gd php-mbstring php-xml php-pdo php-mysql -y
COPY composer.sh .
    RUN chmod +x composer.sh && ./composer.sh
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash - && yum remove epel-release -y && yum install nodejs npm -y
RUN git clone https://github.com/rappasoft/laravel-5-boilerplate.git && \
    cd laravel-5-boilerplate && composer install && npm install -f && npm install acorn && npm run dev

COPY env laravel-5-boilerplate/.env
RUN cd laravel-5-boilerplate && php artisan key:generate && php artisan migrate && php artisan db:seed && npm run dev && \
    php artisan storage:link
WORKDIR laravel-5-boilerplate
CMD php artisan serve --host=0.0.0.0 --port=8080
