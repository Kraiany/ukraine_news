UkraineNews.ArticlesView = Ember.View.extend InfiniteScroll.ViewMixin,
  attributeBindings: ["style"]
  style: Ember.computed ->
    'height: 100%;'
  didInsertElement: ->
    @_super()
    @setupInfiniteScrollListener()
    Ember.run.scheduleOnce 'afterRender', this, ->
      @$(document).bind 'keydown', 'j', @showNextItemHandler = => @get('controller').send 'showNextItem'
      @$(document).bind 'keydown', 'k', @showPreviousItemHandler = => @get('controller').send 'showPreviousItem'
  willInsertElement: ->
    @_super()
    @get('controller').on('homeButtonClicked', this, @homeButtonClickedHandler)
  willDestroyElement: ->
    @teardownInfiniteScrollListener()
    @$(document).unbind 'keydown', @showNextItemHandler
    @$(document).unbind 'keydown', @showPreviousItemHandler
  articleIsShown: Ember.computed 'controller.target.url', ->
    /^\/articles\/[0-9]+$/.test @get('controller.target.url')
  homeButtonClickedHandler: ->
    @$(@get('element')).find('> div:first-child div').get(0).scrollTop = 0
