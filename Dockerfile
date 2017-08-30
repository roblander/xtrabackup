FROM ubuntu:16.04

# Install utils
RUN apt-get update && apt-get install -y wget cron && rm -rf /var/lib/apt

WORKDIR /root

# Setup Percona Xtrabackup
RUN wget https://repo.percona.com/apt/percona-release_0.1-4.xenial_all.deb && dpkg -i percona-release_0.1-4.xenial_all.deb && rm percona-release_0.1-4.xenial_all.deb
RUN apt-get update && apt-get install -y percona-xtrabackup-24 && rm -rf /var/lib/apt

USER root:root

ADD backup.sh backup.sh
ADD backup.sh restore.sh
ADD backup.sh rotate.sh

RUN chmod +x backup.sh
RUN chmod +x restore.sh
RUN chmod +x rotate.sh

# Setup cron
ADD crontab /etc/cron.d/hello-cron
RUN chmod 0644 /etc/cron.d/hello-cron
RUN touch /var/log/cron.log

ADD start.sh /bin/start.sh
RUN chmod +x /bin/start.sh

CMD /bin/bash /bin/start.sh
