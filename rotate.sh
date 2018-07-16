ls -tp ./backups | grep -v '/$' | tail -n +$LEFT_BACKUPS | xargs -I {} rm ./backups/{}
