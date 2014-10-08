UkraineNews.ArticlesCollectionView = Em.CollectionView.extend
  tagName: 'div'
  contentBinding: 'controller.model'
  classNames: ['inf-scroll-inner-container', 'list-group', 'articles']
  itemViewClass: 'UkraineNews.ArticleCellView'
