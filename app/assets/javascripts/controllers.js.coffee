Embardy.ApplicationController = Ember.Controller.extend()


Embardy.ItemIndexMixin = Ember.Mixin.create
  _itemIndex: -1
  itemIndex: ( ->
    @incrementProperty '_itemIndex'
  ).property().volatile()


Embardy.GridController = Ember.ArrayController.extend Embardy.ItemIndexMixin


Embardy.ColumnController = Ember.ObjectController.extend Embardy.ItemIndexMixin,
  needs: 'grid'
  column: ( ->
    @get('controllers.grid.itemIndex')
  ).property()


activeQuestionController = null
Embardy.QuestionController = Ember.ObjectController.extend
  _row: null
  row: ( ->
    row = @get("_row") || this.get('target.target.itemIndex')
    @set("_row", row)
    row
  ).property()

  price: ( ->
    (@get("row") + 1)* 200
  ).property()

  column: Em.computed.alias('target.target.column')

  selected: false
  answered: false

  dismissQuestion: ->
    @set 'selected', false

  selectQuestion: ->

    return if @get("answered")

    if activeQuestionController
      activeQuestionController.setProperties
        selected: false
        answered: true

      if activeQuestionController == @
        activeQuestionController = null
        return

    activeQuestionController = @
    @set 'selected', true


