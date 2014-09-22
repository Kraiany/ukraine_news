UkraineNews.ApplicationController = Ember.Controller.extend
  needs: ['articles']
  actions:
    homeButtonClicked: ->
      @transitionToRoute 'articles.index'
    showNextItem: ->
      @get('controllers.articles').send 'showNextItem'
    showPreviousItem: ->
      @get('controllers.articles').send 'showPreviousItem'
