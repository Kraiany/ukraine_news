class Api::ArticlesController < Api::BaseController
  actions :all, only: %i[index show]

  def index(options={}, &block)
    options = options.merge( { meta: {
      total_entries: collection.total_count,
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      per_page: collection.limit_value
    } } )

    index!(options)
  end
  protected
    def collection
      @articles ||= end_of_association_chain.scraped.order('published_at DESC').page(params[:page])
    end

    def default_serializer_options
      if params[:action] == 'show'
        {root: false}
      end
    end
end
