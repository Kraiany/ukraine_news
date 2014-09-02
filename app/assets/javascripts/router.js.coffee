# For more information see: http://emberjs.com/guides/routing/
UkraineNews.Router.map ()->
  @resource 'articles', ->
    @route 'index'
    @resource 'article', {path: ':article_id'}

