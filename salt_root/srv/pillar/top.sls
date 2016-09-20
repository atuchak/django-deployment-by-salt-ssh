base:
  '*':
    - runtime_env
    - roles
    - config


  # default settings
    - private/default

  # production settings, override default settings
  '.*-production':
    - match: pcre
    - private/production

