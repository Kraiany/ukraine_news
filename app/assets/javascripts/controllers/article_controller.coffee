UkraineNews.ArticleController = Ember.ObjectController.extend Ember.Evented,
  needs: ['articles']
  contentDidChange: Ember.observer 'model', ->
    @set('controllers.articles.currentArticle', @get('model'))
