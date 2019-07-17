FROM nginx:alpine

ARG CERTBOT_AUTO_URL

USER root

# INSTALL CERTBOT-AUTO
RUN wget ${CERTBOT_AUTO_URL} \
&& mv certbot-auto /usr/local/bin/certbot-auto \
&& chown root /usr/local/bin/certbot-auto \
&& chmod 0755 /usr/local/bin/certbot-auto

# STABLISH CRON
RUN echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/local/bin/certbot-auto renew" | sudo tee -a /etc/crontab > /dev/null

RUN usermod nginx -g root

USER nginx

COPY start.sh .

RUN chmod nginx

CMD ["/bin/sh", "-c", "start.sh"]