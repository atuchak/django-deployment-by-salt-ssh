postgres_private:
  users:
    postgres:
      is_superuser: True
      password: default_pg_password

    django_demo:
      password: default_django_demo_password

  dbs:
    django_demo:
      owner: django_demo
