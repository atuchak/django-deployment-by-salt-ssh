from django.http import HttpResponse


def root_view(request):

    return HttpResponse('root_view')