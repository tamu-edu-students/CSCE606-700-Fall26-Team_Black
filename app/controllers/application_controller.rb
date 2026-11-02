class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) only useful if we include name in signup.
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  private

  def record_not_found
    render file: Rails.root.join("public/404.html"), status: :not_found, formats: [ :html ]
  end
end
