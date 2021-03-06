class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def instagram
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.token = request.env["omniauth.auth"].credentials.token
    @user.save
    if @user.persisted?
      session["devise.instagram_data"] = request.env["omniauth.auth"]
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    else
      set_flash_message(:alert, :failure, kind: "Instagram", reason: @user.errors.to_s) if is_navigational_format?
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
