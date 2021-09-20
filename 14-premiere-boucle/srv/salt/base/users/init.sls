xavki:
  group.present:
    - gid: 2000
    - addusers:
      - vagrant

{% for user_name, user_params in pillar['users'].items() %}
Create user {{ user_name }}:
  user.present:
    - name: {{ user_name }}
    - password: {{ user_params.password }}
    - uid: {{ user_params.uid }}
{% endfor %}

