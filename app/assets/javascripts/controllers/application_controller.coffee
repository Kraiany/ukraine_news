UkraineNews.ApplicationController = Ember.Controller.extend
  needs: ['articles']
  actions:
    showNextItem: ->
      @get('controllers.articles').send 'showNextItem'
    showPreviousItem: ->
      @get('controllers.articles').send 'showPreviousItem'
