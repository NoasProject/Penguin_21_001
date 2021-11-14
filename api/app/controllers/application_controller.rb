class ApplicationController < ActionController::API
    before_action :set_user, except: [:login]

    # 取得用関数
    protected
        def getUserId
            @userId
        end

        def getUser
            @user
        end

    private
        # TokenからUser情報を設定する
        def set_user
            logger.debug(params);
            @user = User.find_by(login_token: params[:login_token]);
            # AuthError.
            if @user == nil
                logger.debug("Tokenが存在しないため、Userを取得できませんでした, Token: #{params[:login_token]}")
                render json: @todo.errors, status: :unprocessable_entity
            end
            logger.debug(@user.id);
            @userId = @user.id
        end
        
        # user tokenを更新する
        def update_user_token
            if @user != nil
                # tokenを更新する
                @params[:login_token] = get_user_token;

                if @user.update(@params)
                    return true;
                end

                return false;
            end

            return true;
        end

        # 新しいTokenを発行する
        def get_user_token
            return SecureRandom.alphanumeric(12);
        end
end
