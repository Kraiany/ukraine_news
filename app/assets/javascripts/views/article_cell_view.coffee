UkraineNews.ArticleCellView = Em.View.extend
  templateName: 'article_cell'
  didInsertElement: ->
    @_super()
    @$(@get('element')).find(".timeago").timeago()
