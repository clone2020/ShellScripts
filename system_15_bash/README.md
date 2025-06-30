- [x] Script 1 check system health like a boss
- Script: check_system_health.sh
```sh
chmod +x check_system_health.sh
./check_system_health.sh
```

- [x] Script 2 find the biggest files eating your disk
- Script: biggest_files.sh
```sh
chmod +x biggest_files.sh
./biggest_files.sh /var/log
```

- [x] Script 3 clean log files older than X days
- Script: clean_old_logs.sh
```sh
chmod +x clean_old_logs.sh
./clean_old_logs.sh /your/logs 14
```

- [x] Script 4 auto-deploy a Docker container like a lazy genius
- Script: auto_deploy_docker.sh
```sh
chmod +x auto_deploy_docker.sh
./auto_deploy_docker.sh
```

- [x] Script 5 ping test for network troubleshooting
- Script: ping_test.sh
```sh
chmod +x ping_test.sh
./ping_test.sh yourdomain.com
```

- [x] Script 6 automate git commits and pushes because you forget every time
- Script: git_push_auto.sh
```sh
chmod +x git_push_auto.sh
./git_push_auto.sh "🔥 quick fix before lunch"
```

- [x] Script 7 backup your PostgreSQL database before disaster strikes
- Script: pg_backup.sh
```sh
chmod +x pg_backup.sh
./pg_backup.sh yourdb /your/backup/folder your_pg_user
```

- [x] Script 8 compress and archive directories like a storage wizard
- Script: archive_directory.sh
```sh
chmod +x archive_directory.sh
./archive_directory.sh /etc /backups
```

- [x] Script 9 detect file changes in a directory (like a sneaky watchdog)
- Script: watch_directory.sh
```sh
Requirements:
You need inotify-tools installed:

sudo apt install inotify-tools

Usage:

chmod +x watch_directory.sh
./watch_directory.sh /your/important/folder
```

- [x] Script 10 detect failed SSH login attempts (and catch the sneaky bois)
- Script: detect_ssh_failures.sh
```sh
chmod +x detect_ssh_failures.sh
./detect_ssh_failures.sh
```

- [x] Script 11 check if a service is running (restart it like a boss if it's not)
- Script: watchdog_service.sh
```sh
chmod +x watchdog_service.sh
./watchdog_service.sh your_service_name
```

- [x] Script 12 remove dangling Docker images and volumes (because disk space is precious)
- Script: docker_cleanup.sh
```sh
chmod +x docker_cleanup.sh
./docker_cleanup.sh
```

- [x] Script 13 update and upgrade all packages safely without nuking your system.
- Script: safe_upgrade.sh
```sh
chmod +x safe_upgrade.sh
./safe_upgrade.sh
```

- [x] Script 14 test a URL and alert if it fails because downtime sucks.
- Script: url_health_check.sh
```sh
chmod +x url_health_check.sh
./url_health_check.sh your_url
```

- [x] Script 15 rotate logs and archive them before they bury your server.
- Script: rotate_logs.sh
```sh
chmod +x rotate_logs.sh
./rotate_logs.sh /var/log /var/log/archived 5
```