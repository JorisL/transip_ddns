FROM php:7.4-alpine

ENV DOMAIN_NAME ""

# install required (and some usefull) binaries
RUN apk add --no-cache bash nano bind-tools

# copy dns update shell script to /usr/src
COPY ./src/ /usr/src/
# copy TransIP API to /usr/bin
COPY ./bin/ /usr/bin/

# create cron file to run dns update script every 15 minutes, with the DOMAIN_NAME environment variable, and output status to STDOUT/STDERR
RUN mkdir /etc/cron.d/
RUN echo "*/15 * * * * /usr/src/set_transip_dns.sh \$DOMAIN_NAME > /proc/1/fd/1 2>/proc/1/fd/2" > /etc/cron.d/set_transip_dns_cron

# make copied binaries, scripts, and cron files executable
RUN chmod +x /usr/bin/tipctl.phar
RUN chmod +x /usr/src/set_transip_dns.sh
RUN chmod +x /etc/cron.d/set_transip_dns_cron

# run cron in foreground (a.k.a. indefinetly such that container doesn't close)
RUN crontab /etc/cron.d/set_transip_dns_cron
CMD crond -f