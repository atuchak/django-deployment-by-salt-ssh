appuser-group:
  group.present:
    - name: appuser
    - gid: 100001
    - system: True

appuser:
  user.present:
    - shell: /bin/bash
    - home: /home/appuser
    - createhome: True
    - uid: 100001
    - gid: 100001
    - optional_groups:
      - www-data
      - nginx
    - require:
      - group: appuser-group


{% set app = 'django_demo' %}
{% if app in salt['pillar.get']('roles') %}
/var/log/{{ app }}:
  file.directory:
    - makedirs: True
    - user: appuser
    - group: appuser

/opt/{{ app }}/media:
  file.directory:
    - makedirs: True
    - user: appuser
    - group: appuser

/opt/{{ app }}/settings/db.yaml:
  file.managed:
    - source: salt://apps/{{ app }}/settings/db.yaml
    - template: jinja
    - makedirs: True
    - user: appuser
    - group: appuser

/opt/{{ app }}/settings/common.yaml:
  file.managed:
    - source: salt://apps/{{ app }}/settings/common.yaml
    - template: jinja
    - makedirs: True
    - user: appuser
    - group: appuser

{% endif %}