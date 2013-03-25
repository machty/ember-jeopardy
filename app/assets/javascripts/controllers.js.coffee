
# This is a hacky mixin for controller's that is used
# to enable child views/controllers to look up their
# index within the parent controller. We use this 
# to calculate rows/columns so that each tile
# can figure out what its row and column is and 
# perform the necessary calculations for tile placement.
# Note that this hack only works because the grid is 
# only rendered once in the application. If the grid
# or certain tiles had to be re-created/re-rendered,
# this mixin would probably break, but it works for
# what we need.
Embardy.ItemIndexMixin = Ember.Mixin.create
  _itemIndex: -1
  itemIndex: ( ->
    @incrementProperty '_itemIndex'
  ).property().volatile()


# GridController uses the above mixin to provide ColumnController
# its column index.
Embardy.GridController = Ember.ArrayController.extend Embardy.ItemIndexMixin,
  activeQuestionController: null


# ColumnController uses the above mixin to provide QuestionController
# its row index. (CategoryControllers just rightly assume their row is 0).
Embardy.ColumnController = Ember.ObjectController.extend Embardy.ItemIndexMixin,
  needs: 'grid'
  column: ( ->
    @get('controllers.grid.itemIndex')
  ).property()


Embardy.QuestionController = Ember.ObjectController.extend

  # We'll need to grab information from the singleton
  # GridController in `selectQuestion`. By specifying
  # 'grid' in the needs property, Ember will automatically
  # inject the controller into the `controllers.grid` 
  # property on every instance of this controller.
  needs: ['grid']

  _row: null
  row: ( ->
    # This retrieves the row from the ColumnController and
    # caches it. If it didn't cache, it might continue to
    # increment the current index value on ColumnController
    # and lead to incorrect results.

    # Note the `target.target` is not ideal, but is an 
    # alternative to using the presently incomplete
    # {{control}} helper, which would allow us to rely
    # on controller/subcontainer hierarchy logic to
    # more directly query values on the parent controller.
    # `target.target` works because when `itemController`s
    # are specified in Handlebars, the `itemController`s'
    # `target` properties get set to the parent controller,
    # so you can just follow the chain to the controller you
    # need. Again, brittle, but works for the time being 
    # until {{control}} is ready for prime time.
    row = @get("_row") || this.get('target.target.itemIndex')
    @set("_row", row)
    row
  ).property()

  price: ( ->
    # Calculate the dollar value of a given question... $200, $400, etc.
    (@get("row") + 1)* 200
  ).property()

  column: Em.computed.alias('target.target.column')

  selected: false
  answered: false

  selectQuestion: ->

    # Don't flip over questions that have already been answered.
    return if @get("answered")

    gridController = @get("controllers.grid")
    activeQuestionController = gridController.get("activeQuestionController")

    if activeQuestionController

      # If there's a currently selected/active question,
      # deselect it and mark it as answered.
      activeQuestionController.setProperties
        selected: false
        answered: true

      # If the activeQuestionController was this controller,
      # don't do anything else.
      if activeQuestionController == @
        gridController.set "activeQuestionController", null
        return

    # Mark the new activeQuestionController as this controller
    # and mark this controller as selected. This will re-calculate
    # the `style` computed property on TileView to cause it
    # to flip over.
    gridController.set "activeQuestionController", @
    @set 'selected', true


