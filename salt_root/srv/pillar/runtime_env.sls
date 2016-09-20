{% import_yaml "runtime_env.yaml" as runtime_env_data %}

{% for k,v in runtime_env_data.iteritems() %}
  {% for x in v %}
    {% if x == grains['id'] %}
      runtime_env: {{k}}
    {% endif %}
  {% endfor %}
{% endfor %}


