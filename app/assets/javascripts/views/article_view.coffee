UkraineNews.ArticleView = Em.View.extend
  willInsertElement: ->
    @get('controller').on('didTransition', this, @transitionHandler)
  transitionHandler: ->
    return unless @get('element')?
    @get('element').parentNode.scrollTop = 0

