class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
            format.json { head :forbidden, content_type: 'text/html' }
            format.html { redirect_to root_path, notice: exception.message }
            format.js   { head :forbidden, content_type: 'text/html' }
        end
    end


    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :board_id, :cell_id, :cell_kind, :board_kind, :photo, :creation_cell])
            devise_parameter_sanitizer.permit(:account_update, keys: [:name, :age, :board_id, :cell_id, :cell_kind, :board_kind, :photo, :creation_cell])
        end

end
