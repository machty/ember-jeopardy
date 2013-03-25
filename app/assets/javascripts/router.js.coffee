
Embardy.Router.map ->
  @route 'grid', path: '/'


Embardy.GridRoute = Em.Route.extend
  setupController: (controller) ->
    categories = $.parseJSON(Em.$('script[type="text/x-categories-data"]').html()).categories
    controller.set 'content', categories
