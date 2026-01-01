class AccountsController < ApplicationController
  def show
    @user = current_user
  end
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_with_password(account_params)
      bypass_sign_in(@user)
      redirect_to account_path, notice: "アカウント情報を更新しました。"
    else
      flash.now[:alert] = "アカウント情報の更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def account_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :current_password
    )
  end
end
