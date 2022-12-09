#!/bin/bash
# This script backs up the user's home directory

# Set the backup directory
BACKUP_DIR=~/backups

# Set the date
DATE=$(date +%Y-%m-%d)

# Set the backup file name
BACKUP_FILE=$BACKUP_DIR/home-$DATE.tar.gz

# Create the backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

# Create the backup
tar -czf "$BACKUP_FILE" ~/

# Print confirmation
echo "Backup created: $BACKUP_FILE"
