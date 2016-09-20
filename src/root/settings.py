import os
import yaml
from django.utils.translation import ugettext_lazy as _

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# loading settings from config
CONFIG_DIR = os.path.join(BASE_DIR, '../settings')
if not os.path.isdir(CONFIG_DIR):
    CONFIG_DIR = os.path.join(BASE_DIR, '../settings_default')
    if not os.path.isdir(CONFIG_DIR):
        raise FileNotFoundError('neither settings folder, nor default settings folder not found')

with open(os.path.join(CONFIG_DIR, 'db.yaml'), 'r') as f:
    DB_SETTINGS = yaml.load(f)

with open(os.path.join(CONFIG_DIR, 'common.yaml'), 'r') as f:
    COMMON_SETTINGS = yaml.load(f)

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = COMMON_SETTINGS.get('secret_key', 'w_*w2WUn4_rugAbaT&f&unEdrA?E+ra48Us#ecu53brutravupra7rerewucra4u')

DEBUG = COMMON_SETTINGS['debug']

ALLOWED_HOSTS = ['*']

SITE_ID = 1

DEBUG_TOOLBAR_PATCH_SETTINGS = False

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.sites',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'root',
]

MIDDLEWARE = [
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'root.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

DATABASES = {'default': {
    'ENGINE': 'django.db.backends.postgresql',
    'NAME': DB_SETTINGS['default']['db_name'],
    'USER': DB_SETTINGS['default']['user'],
    'PASSWORD': DB_SETTINGS['default'].get('password', ''),
    'HOST': DB_SETTINGS['default']['host'],
    'PORT': DB_SETTINGS['default']['port'],
},
}

# Password validation
# https://docs.djangoproject.com/en/1.10/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
# https://docs.djangoproject.com/en/1.10/topics/i18n/

TIME_ZONE = ''
USE_TZ = True

USE_I18N = True

USE_L10N = True

USE_TZ = True



# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.10/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, '../static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, '../media')

WSGI_APPLICATION = 'root.wsgi.application'
