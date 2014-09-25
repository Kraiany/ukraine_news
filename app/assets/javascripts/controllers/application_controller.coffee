UkraineNews.ApplicationController = Ember.Controller.extend Ember.Evented,
  needs: ['articles']
  actions:
    homeButtonClicked: ->
      if /^\/articles\/index/.test @get('target.url')
        @get('controllers.articles').trigger 'homeButtonClicked'
      else
        @transitionToRoute 'articles.index'
    showNextItem: ->
      @get('controllers.articles').send 'showNextItem'
    showPreviousItem: ->
      @get('controllers.articles').send 'showPreviousItem'
