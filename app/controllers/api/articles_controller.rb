class Api::ArticlesController < Api::BaseController
  actions :all, only: %i[index show]
  protected
    def collection
      @articles ||= end_of_association_chain.order('published_at DESC').page(params[:page])
    end
end
