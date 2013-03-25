
Embardy.Router.map ->
  @route 'grid', path: '/'


Embardy.GridRoute = Em.Route.extend
  setupController: (controller) ->
    # Set the category information on the controller, which
    # comes from a YAML file whose JSON contents has been
    # rendered into a script tag on the Rails view.
    categories = $.parseJSON(Em.$('script[type="text/x-categories-data"]').html()).categories
    controller.set 'content', categories
