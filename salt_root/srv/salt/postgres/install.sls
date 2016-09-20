postgres-repo:
  pkgrepo.managed:
    - humanname: postgres
    - name: deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main
    - dist: jessie-pgdg
    - file: /etc/apt/sources.list.d/postgres.list
    - gpgcheck: 1
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc


pgbouncer_installed:
  pkg:
    - name: pgbouncer
    - installed


postgresql-contrib-9.5_installed:
  pkg:
    - name: postgresql-contrib-9.5
    - installed


postgresql-9.5_installed:
  pkg:
    - name: postgresql-9.5
    - installed

pg_us_utf-8_locale:
  locale.present:
    - name: en_US.UTF-8

pg_ru_utf-8_locale:
  locale.present:
    - name: ru_RU.UTF-8

create_main_9.5_cluster:
  cmd.run:
    - name: pg_createcluster --start --locale=ru_RU.UTF-8 -e UTF-8 --lc-collate=ru_RU.UTF-8 9.5 main
    - cwd: /tmp
    - unless: test -d /etc/postgresql/9.5/main
    - require:
      - pkg: postgresql-9.5