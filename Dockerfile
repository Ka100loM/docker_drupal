FROM drupal
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer 
# Install git
RUN apt-get update
RUN apt-get -y install git
RUN apt-get update && apt-get install -y mysql-client openssh-client rsync \
  && composer global require drush/drush:8.* \
  && rm -f /usr/local/bin/drush \
  && ln -s ~/.composer/vendor/bin/drush /usr/local/bin/drush \
  && drush core-status -y \
  && rm -rf /var/lib/apt/lists/*
RUN cd /var/www/html \
    && composer require drush/drush drupal/admin_toolbar \
    && composer require drupal/devel --dev  
