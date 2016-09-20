nginx-repo:
  pkgrepo.managed:
    - humanname: nginx
    - name: deb http://nginx.org/packages/debian/ jessie nginx
    - dist: jessie
    - file: /etc/apt/sources.list.d/nginx.list
    - gpgcheck: 1
    - key_url: http://nginx.org/keys/nginx_signing.key


nginx_installed:
  pkg:
    - name: nginx
    - installed


/etc/nginx/conf.d/default.conf:
  file.absent

/etc/nginx/sites-enabled/default:
  file.absent

/etc/nginx/sites-enabled:
  file.directory:
    - makedirs: True
    - user: nginx
    - group: nginx

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/etc/nginx/nginx.conf
    - template: jinja

{% set app = 'django_demo' %}
{% if app in salt['pillar.get']('roles') %}
/etc/nginx/sites-enabled/demo.com.conf:
  file.managed:
    - source: salt://nginx/etc/nginx/sites-enabled/demo.com.conf
    - template: jinja
    - context:
      app: {{ app }}
    - watch_in:
      - service: nginx_service
{% endif %}

nginx_check_config:
  cmd.run:
    - name: nginx -t

nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-enabled
#      - file: /etc/nginx/sites-enabled/demo.com.conf


