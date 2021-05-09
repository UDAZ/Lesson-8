# Lesson-8 メール送信機能
### ①メールアドレスとアプリパスワードの環境変数の設定
#### ①ターミナルで.bash_profileを編集
```
vim ~/.bash_profile
```
#### ②.bash_profileを編集
iコマンドで下部に記載
```
export GMAIL='メールアドレス'
export GPASS='パスワード'
```
escで編集モード終了
:wqコマンドで保存して終了

環境変数の適用
```
source ~/.bash_profile
```
#### ③railsコンソールで環境変数の確認
ターミナル
```
rails c
```
rails コンソールで環境変数確認
```
ENV['GMAIL']
ENV['GPASS']
```
rails コンソールの終了
```
exit
```
#### ※railsコンソールが動作しない場合
```
bundle exec spring stop
```
### ②devlopment.rbにメール設定を追記
config/environments/development.rb
```

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000'}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => 'smtp.gmail.com',
    :port => 587,
    :domain => 'gmail.com',
    :user_name => ENV['GMAIL'],
    :password => ENV['GPASS'],
    :authentication => :plain,
    :enable_starttls_auto => true
  }

```
### ③メイラーの作成
```
rails generate mailer ThanksMailer
```
### ④application_mailerの編集
app/mailers/application_mailer.rbの編集
```
class ApplicationMailer < ActionMailer::Base
  default from: "管理人 <from@example.com>"
  layout 'mailer'
end
```
### ⑤thanks_mailerの編集
app/mailer/thanks_mailer.rb
```
class ThanksMailer < ApplicationMailer
    def send_when_user_registration(user)
        @user = user
        mail to: user.email, subject: '【bookers】ご登録ありがとうございます'
    end
end
```
### ⑥thanks_mailerのviewを作成
#### ①send_when_user_registration.html.erbの作成
```
<h2><%= @user.name %> 様</h2>
<p>この度は、ご登録ありがとうございました。<br>
以下の内容で登録いたしました。</p>

<p>今後ともをよろしくお願いいたします。</p>
```
#### ②send_when_user_registration.text.erbの作成
```
===============================
<%= @user.name %> 様
===============================

この度は、ご登録ありがとうございました。
以下の内容で登録いたしました。

今後とも bookers をよろしくお願いいたします。
```
### ⑦deviseコントローラーのオーバーライド
#### ①deviseコントローラーの作成
```
rails g devise:controllers users
```
#### ②registrations_controller.rbのcreateアクションを上書き
```
    def create
     super
     ThanksMailer.send_when_user_registration(@user).deliver 
    end
```
#### ③ルーティングの変更
routes.rb
```
  devise_for :users, controllers: {
  registrations: "users/registrations"
}
```