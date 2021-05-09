# Lesson-8 メール送信機能
### ①環境変数の設定
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