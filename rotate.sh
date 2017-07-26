ls -tp | grep -v '/$' | tail -n +$LEFT_BACKUPS | xargs -I {} rm -- {}
