class UsersController < ApplicationController
  before_action :set_user, only: %i[ destroy ]

#  def show
#  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # あとからオートログインを実装する。一旦ログイン画面に遷移させる。
      redirect_to root_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_url, notice: "User was successfully destroyed."
  end

#  def edit
#  end

#  def update
#    if @user.update(user_params)
#      redirect_to user_url(@user), notice: "User was successfully updated." }
#    else
#      render :edit, status: :unprocessable_entity }
#    end
#  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
