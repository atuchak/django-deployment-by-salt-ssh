supervisor_installed:
  pkg:
    - name: supervisor
    - installed

supervisor_service:
  service.running:
    - name: supervisor
    - require:
      - pkg: supervisor

{% set app = 'django_demo' %}
{% if app in salt['pillar.get']('roles') %}
/etc/supervisor/conf.d/{{ app }}.conf:
  file.managed:
    - source: salt://supervisor/etc/supervisor/conf.d/{{ app }}.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - cmd: supervisor_restart_new_conf
    - context:
      app: {{ app }}
{% else %}
/etc/supervisor/conf.d/{{ app }}.conf:
  file.absent
{% endif %}


supervisor_restart_new_conf:
  cmd.run:
    - names:
      - supervisorctl update


