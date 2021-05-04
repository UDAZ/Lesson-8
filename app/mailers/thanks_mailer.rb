class ThanksMailer < ApplicationMailer
    def send_when_user_registration(user)
        @user = user
        mail to: user.email, subject: '【bookers】ご登録ありがとうございます'
    end
end
