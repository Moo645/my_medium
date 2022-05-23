class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  
  private
  def record_not_found
    render file: "#{Rails.root}/public/404.html",
           status: :not_found,
           layout: true
  end

  def record_not_unique
    render file: "#{Rails.root}/public/422.html"
  end

end
