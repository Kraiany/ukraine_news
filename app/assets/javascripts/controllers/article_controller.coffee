UkraineNews.ArticleController = Ember.ObjectController.extend
  needs: ['articles']
  contentDidChange: Ember.observer 'model', ->
    @set('controllers.articles.currentArticle', @get('model'))
