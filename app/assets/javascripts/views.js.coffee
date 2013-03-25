
# This is used to determine the vendor-prefixed CSS transform
# property for controlling the orientation of a grid tile.
cssPrefixed = (feature) ->
  Modernizr.prefixed(feature).replace(/([A-Z])/g, (str,m1) -> '-' + m1.toLowerCase()).replace(/^ms-/,'-ms-')

NUM_ROWS = 6
NUM_COLUMNS = 6
TRANSFORM = cssPrefixed 'transform'


# We wouldn't otherwise need to manually define this class,
# but we need the outer application view to have a specific
# class name so it can be stylized to frame the 3D grid.
Embardy.ApplicationView = Ember.View.extend
  classNames: ['application-view']


Embardy.TileView = Ember.View.extend

  classNames: ['tile-view']

  # This makes it so that the when the tile is selected, it
  # will have a 'selected' class.
  classNameBindings: ['controller.selected']

  # Bind the style attribute to the computed property below.
  attributeBindings: ['style']
  style: ( ->

    # If this tile is selected, flip it over.
    if @get("controller.selected")
      return "#{TRANSFORM}: rotateY(180deg)"

    # `viewport` was a property injected into Ember.View inside `viewport.js.coffee`
    tileHeight = @get("viewport.height")
    tileWidth = @get("viewport.width")

    # Calculate where in 3d space the tile should be laid out.
    # To simplify things, in the 2D world, we set each tile to 
    # be absolute positioned to fill the screen, so that it's 
    # width and height equal that of the current browser window size.
    # We correct this by 3D transforming the tiles to "push" them
    # back into the screen. Figuring out where they go is just
    # a simple matter of looking up their rows and columns and
    # performing the necessary x and y calculations. 
    row = @get("row")
    column = @get("column")
    x = Math.round((column - NUM_COLUMNS/2) * tileWidth + tileWidth / 2)
    y = Math.round((row - NUM_ROWS/2) * tileHeight + tileHeight / 2)

    # The -5000px was chosen by trial and error, and needs to correspond 
    # with a sensible value for the CSS3 perspective property set
    # on application-view in application.css.sass. A lower value than
    # 5000 yielded very bizarre, over-dramatic perspective effects when
    # the card was flipped over.
    "#{TRANSFORM}: translate3d(#{x}px, #{y}px, -5000px)"

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

