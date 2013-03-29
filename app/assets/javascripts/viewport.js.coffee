
# Since all TileView's need to recalculate their location on the
# screen based on browser dimensions, it's convenient to encapsulate
# some of that viewport dimension calculation logic into a separate
# place so that only a single object is watching for window 
# resize events, and all the information about screen size is
# coming from one place. We'll then inject this property on all
# Ember.View's so that Ember.View subclasses can bind to
# the width and height properties of the viewports.
$window = Em.$(window)
Embardy.Viewport = Em.Object.extend
  init: ->
    @_super()

    # Prevent resize events from fully firing until a 
    # 'resize' event hasn't been received for 300ms.
    # This is often called debouncing, which just means
    # a single event will be fired in place of many 
    # clustered events.
    @_debounceTimerId = null
    $window.resize =>
      Em.run.cancel @_debounceTimerId if @_debounceTimerId
      @_debounceTimerId = Em.run.later this, '_updateDimensions', 300

    @_updateDimensions()

  _updateDimensions: ->
    @_debounceTimerId = null
    @setProperties
      width:  $window.width()
      height: $window.height()

  # These values get immediately set from init -> _updateDimensions
  width: 0
  height: 0


#Embardy.register 'viewport:main', Embardy.Viewport
#Ember.Application.initializer
  #name: 'viewport'
  #initialize: (container) ->
    #container.typeInjection 'view', 'viewport', 'viewport:main'



# A type injection would be nice here, but Ember doesn't offer
# 100% support for it for Ember.View yet. This makes it so that
# all instances of Ember.View and subclasses will have
# a `viewport` property they can bind to.
Ember.View.reopen
  viewport: Embardy.Viewport.create()


