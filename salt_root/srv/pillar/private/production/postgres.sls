postgres_private:
  users:
    postgres:
      is_superuser: True
      password: prod_pass_for_postgres

    django_demo:
      password: prod_pass_for_django_demo

  dbs:
    django_demo:
      owner: django_demo
