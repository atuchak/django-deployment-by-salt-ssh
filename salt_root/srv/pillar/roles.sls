{% import_yaml "roles.yaml" as roles_data %}

{% if roles_data %}
{% if roles_data.get(grains['id'], None) %}
roles:
{% for x in  roles_data.get(grains['id']) %}
  - {{x}}
{% endfor %}
{% endif %}
{% endif %}


