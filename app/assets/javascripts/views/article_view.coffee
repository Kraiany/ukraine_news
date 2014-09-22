UkraineNews.ArticleView = Em.View.extend
  willInsertElement: ->
    @get('controller').on('didTransition', this, @transitionHandler)
  transitionHandler: ->
    @get('element').parentNode.scrollTop = 0

