UkraineNews.ArticlesView = Ember.View.extend
  attributeBindings: ["style"]
  style: Ember.computed ->
    'height: 100%;'
  didInsertElement: ->
    @_super()
    jQuery("abbr.timeago").timeago()
    Ember.run.scheduleOnce 'afterRender', this, ->
      @$(document).bind 'keydown', 'j', @showNextItemHandler = => @get('controller').send 'showNextItem'
      @$(document).bind 'keydown', 'k', @showPreviousItemHandler = => @get('controller').send 'showPreviousItem'
  willInsertElement: ->
    @get('controller').on('homeButtonClicked', this, @homeButtonClickedHandler)
  willDestroyElement: ->
    @$(document).unbind 'keydown', @showNextItemHandler
    @$(document).unbind 'keydown', @showPreviousItemHandler
  articleIsShown: Ember.computed 'controller.target.url', ->
    /^\/articles\/[0-9]+$/.test @get('controller.target.url')
  homeButtonClickedHandler: ->
    @$(@get('element')).find('> div:first-child div').get(0).scrollTop = 0
  gestures:
    touchEnd: (event) ->
      @$(event.target).click()
      return false
