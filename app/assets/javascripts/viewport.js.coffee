$window = Em.$(window)
Embardy.Viewport = Em.Object.extend
  init: ->
    @_super()

    # Prevent resize events from fully firing until a 
    # 'resize' event hasn't been received for 300ms.
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


# A type injection would be nice here, but Ember doesn't offer
# 100% support for it for Ember.View yet.
Ember.View.reopen
  viewport: Embardy.Viewport.create()


