UkraineNews.ArticlesView = Ember.View.extend
  attributeBindings: ["style"]
  style: Ember.computed ->
    'height: 100%;'
  didInsertElement: ->
    @_super()
    jQuery("abbr.timeago").timeago()
    Ember.run.scheduleOnce 'afterRender', this, ->
      @$(document).bind 'keydown', 'j', @showNextItemHandler = => @showNextItem(this)
      @$(document).bind 'keydown', 'k', @showPreviousItemHandler = => @showPreviousItem(this)
  willDestroyElement: ->
    @$(document).unbind 'keydown', @showNextItemHandler
    @$(document).unbind 'keydown', @showPreviousItemHandler
  articleIsShown: Ember.computed 'controller.target.url', ->
    /^\/articles\/[0-9]+$/.test @get('controller.target.url')
  showNextItem: (args...) ->
    items = @get('controller.model.content')
    current_item_index = items.indexOf @get('controller.currentArticle')
    next_item = items[current_item_index + 1]
    router = this.get('controller.target.router')
    router.transitionTo('article', next_item) if next_item?
  showPreviousItem: (args...) ->
    items = @get('controller.model.content')
    current_item_index = items.indexOf @get('controller.currentArticle')
    next_item = items[current_item_index - 1]
    router = this.get('controller.target.router')
    router.transitionTo('article', next_item) if next_item?
