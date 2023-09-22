class ApplicationController < ActionController::Base
    # For pagination
    include Pagy::Backend

    protect_from_forgery with: :exception
    
    # To permit additional parameters to certain actions of Devise; the lazy way
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
        def configure_permitted_parameters
            # There are only three actions in Devise that allow any set of parameters to be passed down to the model, therefore requiring sanitization (strong typing)
            # By default:
            ## sign_in (Devise::SessionsController#create) - Permits only authentication keys (e.g. email)
            ## sign_up (Devise::RegistrationsController#create) - Permits authentication keys + 'password' and 'password_confirmation'
            ## account_update (Devise::RegistrationsController#update) - Permits authentication keys + password, password_confirmation, and current_password
            
            devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
            devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :first_name, :last_name, :contact_no, :address])

            # To permit additional parameters, below is an example:
            # devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

            # To permit nested attributes
            # devise_parameter_sanitizer.permit(:sign_up, keys: [address_attributes: [:country, :state, :city, :area, :postal_code]])
        end

    # If there are multiple Devise models, construct different parameter sanitizer classes per model
    # Inherit from Devise::ParameterSanitizer and add own logic
    # def devise_parameter_sanitizer
    #     if resource_class == User
    #         User::ParameterSanitizer.new(User, :user, params)
    #     else
    #         super # Use the default one
    #     end
    # end
end
