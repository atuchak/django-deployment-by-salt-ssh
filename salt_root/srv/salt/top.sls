base:
  '*':
    - common

  'roles:nginx':
    - match: pillar
    - nginx

  'roles:postgres':
    - match: pillar
    - postgres

  'roles:python3':
    - match: pillar
    - python3

  'roles:supervisor':
    - match: pillar
    - apps
    - supervisor

