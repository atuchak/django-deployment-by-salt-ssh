ntpdate:
  pkg.installed

ntp_crontab:
  cron.present:
    - identifier: ntp
    - name: ntpdate pool.ntp.org
    - user: root
    - minute: '*/30'