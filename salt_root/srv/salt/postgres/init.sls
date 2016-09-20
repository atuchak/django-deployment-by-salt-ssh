{% include 'postgres/install.sls' %}

{% set pg_version = '9.5' %}


/etc/postgresql/{{ pg_version }}/main/pg_hba.conf:
  file.managed:
    - source: salt://postgres/etc/postgresql/{{ pg_version }}/main/pg_hba.conf
    - template: jinja
    - user: postgres
    - group: postgres
    - mode: 640
    - require:
      - pkg: postgresql-{{ pg_version }}_installed
    - require_in:
      - cmd: postgres_reload

/etc/pgbouncer/userlist.txt:
  file.managed:
    - source: salt://postgres/etc/pgbouncer/userlist.txt
    - template: jinja
    - user: postgres
    - group: postgres
    - mode: 640
    - require:
      - pkg: pgbouncer_installed

/etc/pgbouncer/pgbouncer.ini:
  file.managed:
    - source: salt://postgres/etc/pgbouncer/pgbouncer.ini
    - template: jinja
    - user: postgres
    - group: postgres
    - mode: 640
    - require:
      - pkg: pgbouncer_installed

/etc/default/pgbouncer:
  file.managed:
    - source: salt://postgres/etc/default/pgbouncer
    - template: jinja
    - user: postgres
    - group: postgres
    - mode: 640
    - require:
      - pkg: pgbouncer_installed

pgbouncer_restart:
  cmd.wait:
    - names:
      - /etc/init.d/pgbouncer restart
    - watch:
      - file: /etc/pgbouncer/pgbouncer.ini
      - file: /etc/pgbouncer/userlist.txt
      - file: /etc/default/pgbouncer


pg_user_root:
  postgres_user.present:
    - name: root
    - superuser: True

  cmd.run:
    - name: /etc/init.d/postgresql reload

{% set postgres_users = salt['pillar.get']('postgres_private:users', {}) %}
{% set postgres_dbs = salt['pillar.get']('postgres_private:dbs', {}) %}

{% if postgres_users %}
{% for user, v in postgres_users.iteritems() %}
pg_user_{{ user }}:
  postgres_user.present:
    - name: {{ user }}
    {% if user == 'postgres' %}
    - superuser: True
    {% endif %}
    - createdb: True
    - login: True
    - password: '{{ v.get('password', '') }}'
    - require:
      - pkg: postgresql-{{ pg_version }}
{% endfor %}
{% endif %}

{% for db, v in postgres_dbs.iteritems() %}
{% set owner = v.get('owner', 'postgres') -%}
db_{{ db }}_exists:
  postgres_database.present:
    - name: {{ db }}
    - owner: {{ owner }}
{% endfor %}


postgres_reload:
  cmd.run:
    - name: /etc/init.d/postgresql reload