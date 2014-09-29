UkraineNews.ApplicationController = Ember.Controller.extend Ember.Evented,
  needs: ['articles']
  is_showing_index: Ember.computed 'target.url', -> /^\/articles\/index/.test @get('target.url')
  actions:
    homeButtonClicked: ->
      if @get('is_showing_index')
        @get('controllers.articles').trigger 'homeButtonClicked'
      else
        @transitionToRoute 'articles.index'
    showNextItem: ->
      @get('controllers.articles').send 'showNextItem'
    showPreviousItem: ->
      @get('controllers.articles').send 'showPreviousItem'
  gestures:
    touchEnd: (event) ->
      @$(event.target).click()
      return false
