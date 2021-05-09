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