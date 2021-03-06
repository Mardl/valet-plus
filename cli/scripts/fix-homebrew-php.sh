#!/usr/bin/env bash

valet stop
sudo killall -9 php-fpm
sudo rm -rf /usr/local/Cellar/php@5.6/5.6.*/var/log
brew remove --force --ignore-dependencies $(brew list | grep php)
bash -c "sudo rm -rf /etc/php.ini /usr/local/bin/php* /usr/local/php* /usr/local/etc/php"
brew upgrade
brew untap homebrew/php
brew install php@7.0
brew link php@7.0 --overwrite --force
sudo ln -sf /usr/local/bin/php* /usr/bin/
HOMEBREW_NO_ENV_FILTERING=1 brew reinstall composer
composer global require techdivision/valet-plus
grep -q 'export PATH="$PATH:$HOME/.composer/vendor/bin"' ~/.bashrc || echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
grep -q 'export PATH="$PATH:$HOME/.composer/vendor/bin"' ~/.zshrc || echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.zshrc
valet install
