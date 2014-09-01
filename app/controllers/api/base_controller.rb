class Api::BaseController < InheritedResources::Base
  respond_to :json, :xml
end
