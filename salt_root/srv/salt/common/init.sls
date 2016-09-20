dnsutils:
  pkg.installed

mc:
  pkg.installed

htop:
  pkg.installed

sysstat:
  pkg.installed

nmap:
  pkg.installed

tcpdump:
  pkg.installed

rcconf:
  pkg.installed

git:
  pkg.installed

screen:
  pkg.installed

libmagic-dev:
  pkg.installed

aptitude:
  pkg.installed

curl:
  pkg.installed

links:
  pkg.installed

iptraf-ng:
  pkg.installed

apt-transport-https:
  pkg.installed

include:
  - common.ntp

/etc/inputrc:
  file.managed:
    - source: salt://common/etc/inputrc
    - user: root
    - group: root
    - mode: 644


