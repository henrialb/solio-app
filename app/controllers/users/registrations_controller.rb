class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix

  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed
    render json: { message: "Something went wrong." }
  end

  # def create
  #   user = User.new(user_params)

  #   if user.save
  #     render json: { msg: "good" }
  #   else
  #     render json: { errors: { "email or password" => ["is invalid"] } }, status: :unprocessable_entity
  #   end
  # end

  # private

  # def user_params
  #   params.require(:user).permit(:email, :password)
  # end
end
