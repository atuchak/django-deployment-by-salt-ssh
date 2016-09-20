{% set app = 'django_demo' %}


/opt/{{ app }}/src:
  file.recurse:
    - source: salt://src
    - user: appuser
    - group: appuser
    - exclude_pat: '*__pycache__*'

/opt/{{ app }}/src/manage.py:
  file.managed:
    - source: salt://src/manage.py
    - makedirs: True
    - mode: 755
    - user: appuser
    - group: appuser

/opt/{{ app }}/requirements/requirements-production.txt:
  file.managed:
    - source: salt://requirements/requirements-production.txt
    - makedirs: True
    - user: appuser
    - group: appuser



del_env_if_reqs_are_changed_{{ app }}:
  cmd.wait:
    - name: rm -rf /opt/{{ app }}/env3
    - watch:
      - file: /opt/{{ app }}/requirements/requirements-production.txt


virtualenv_/opt/{{ app }}/env3:
  virtualenv.managed:
    - name: /opt/{{ app }}/env3
    - system_site_packages: False
    - python: python3
    - user: appuser
    - use_wheel: True
    - pip_upgrade: True
    - pip_exists_action: w
    - requirements: salt://requirements/requirements-production.txt

{{ app }}_collectstatic:
  cmd.run:
    - runas: appuser
    - cwd:  /opt/{{ app }}/src
    - name: source ../env3/bin/activate ; python ./manage.py collectstatic --noinput


/var/backups/{{ app }}:
  file.directory:
    - makedirs: True

{{ app }}_db_backup:
  cmd.run:
    - name: pg_dump -d django_demo > "/var/backups/{{ app }}/bkp_`date +'%m-%d-%Y_%H:%M'`.sql"
# do migrate

supervisor_reload_{{ app }}:
  cmd.wait:
    - names:
      - supervisorctl restart {{ app }}
    - watch:
      - file: /opt/{{ app }}/src