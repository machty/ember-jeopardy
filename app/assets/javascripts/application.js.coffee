#= require preload
#= require jquery
#= require jquery_ujs
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require embardy
window.Embardy = Ember.Application.create
  NUM_ROWS: 6
  NUM_COLUMNS: 6
#= require_tree .

Ember.Application.initializer
  name: 'bullshit',
  initialize: (container, application) ->
    #container.optionsForType('viewport', {singleton: true})
    container.register('viewport:main', application.Viewport)
    container.typeInjection('view', 'viewport', 'viewport:main')
    container.typeInjection('view', 'asshole', 'router:main')
    #debugger
    #container.typeInjection('controller', 'viewport', 'viewport:main')

