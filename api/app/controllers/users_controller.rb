require 'securerandom'

class UsersController < ApplicationController
  before_action :set_login_user, only: [:login]

  # POST /users/register
  # アカウントの作成処理
  def register
    # Idが重複する場合は登録できない
    if User.find_by(login_id: params[:login_id]) != nil
      # すでにアカウントが存在する
      logger.debug("すでにアカウントが存在するため、登録ができませんでした");
      render json: @user.errors, status: :unprocessable_entity
    end

    # アカウントを作成する
    @user = User.new(user_params)
    # tokenを発行する
    @user.login_token = SecureRandom.alphanumeric(12);

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @params = user_params;
    @user = getUser;

    # アカウントが存在しない
    if @user == nil
      logger.debug("アカウントが存在しないためLoginを行えませんでした : #{@params}");
      # すでにアカウントが存在する
      render json: @user.errors, status: :unprocessable_entity
    end

    # アカウントが存在する
    @token = SecureRandom.alphanumeric(12);
    # tokenを更新する
    @params[:login_token] = @token;

    logger.debug("アカウントが存在するため、Tokenの更新を行いました. Token:#{@token}");

    if @user.update(@params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_login_user
      if params[:login_token] != nil
        @user = User.find_by(login_token: params[:login_token])
      else
        @user = User.find_by(login_id: params[:login_id], login_password: params[:login_password])
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :login_id, :login_password)
    end
end
