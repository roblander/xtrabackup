# export all environment variables to use in cron
env | sed 's/^\(.*\)$/export \1/g' > /root/envs.sh
chmod +x /root/envs.sh

# update crontab file with env parameters
sed -i .bak -e s/__BACKUP_CRON__/$BACKUP_CRON/g -e s/__ROTATE_CRON__/$ROTATE_CRON/g /etc/cron.d/hello-cron

# Run the command on container startup
cron && tail -f /var/log/cron.log
