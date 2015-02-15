class Api::ArticlesController < Api::BaseController
  actions :all, only: %i[index show]
  caches_action :show
  caches_action :index, :cache_path => proc { |c|
    c.headers["Content-Type"] = 'application/json; encoding=utf-8'
    p = ["articles-api"]
    p << params[:q].gsub(/\s+/, '_') if params.has_key?(:q)
    p << params[:page] if params.has_key?(:page)
    p.join('-')
  }

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
      @articles ||= end_of_association_chain.published.page(params[:page]).search(title_cont: params[:q]).result
    end

    def default_serializer_options
      if params[:action] == 'show'
        {root: 'Article'}
      end
    end
end
