module ProfileActions
  extend ActiveSupport::Concern

  included do
  
    before_action :set_profile
  end

  def show; end
  def edit; end

  def update
    if @user.update(profile_params)
      redirect_to after_profile_update_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @user = current_user
  end

  def profile_params
    params.require(:user).permit(:name, :profile_photo)
  end
end
