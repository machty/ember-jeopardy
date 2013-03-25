Embardy.ApplicationView = Ember.View.extend
  classNames: ['application-view']


Embardy.TileView = Ember.View.extend

  classNames: ['tile-view']
  attributeBindings: ['style']
  classNameBindings: ['controller.selected']

  style: ( ->
    if @get("controller.selected")
      return "-webkit-transform: rotateY(180deg)"

    row = @get("row")
    column = @get("column")

    tileHeight = @get("viewport.height")
    tileWidth = @get("viewport.width")

    x = Math.round((column - Embardy.NUM_COLUMNS/2) * tileWidth + tileWidth / 2)
    y = Math.round((row - Embardy.NUM_ROWS/2) * tileHeight + tileHeight / 2)

    "-webkit-transform: translate3d(#{x}px, #{y}px, -5000px)"
  ).property('viewport.width', 'viewport.height', 'controller.selected')

  row: 0

  column: Em.computed.alias('controller.column')


Embardy.VerticalAlignView = Ember.View.extend
  classNames: ['vertical-align-view']
  attributeBindings: ['style']
  style: ( ->
    viewport = @get("viewport")
    "width: #{viewport.width}px; height: #{viewport.height}px;"
  ).property('viewport.width', 'viewport.height')

  # This is borrowed from Ember's `linkTo` and makes this
  # view as transparent as possible so that bindings and click
  # handlers get properly passed through to the controller.
  concreteView: ( ->
    @get("parentView")
  ).property('parentView').volatile()


Embardy.CategoryView = Embardy.TileView.extend
  templateName: 'category'
  classNames: ['category-view']


Embardy.QuestionView = Embardy.TileView.extend
  templateName: 'question'
  classNames: ['question-view']
  click: ->
    @get("controller").selectQuestion()

  row: ( ->
    @get('controller.row') + 1
  ).property('controller.row')

