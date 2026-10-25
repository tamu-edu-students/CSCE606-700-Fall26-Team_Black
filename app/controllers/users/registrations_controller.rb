class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def respond_with(resource, _opts = {})
    if resource.persisted?
      super
    else
      render "devise/sessions/new", status: :unprocessable_entity
    end
  end
end