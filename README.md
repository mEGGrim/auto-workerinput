auto-workerinput
================
# 概要
工数入力をできるだけ自動化します。


# 必要なもの
1. ruby
1. auto it (http://www.autoitscript.com/site/autoit/)

# 前提
 * 毎日、1日中同じ業務だけやってるのが前提です。
 * 画面のサイズによってスクリプトの修正が必要です。code.rbを適宜修正してください。

# 手順
1. 入力データの準備、作成
 1. きんのすけから出勤簿のCSVをダウンロード

1. 1stWorkerInputを起動
 1. 起動したら工数入力画面を開く
 1. プロジェクトとタスクを選択
 1. 1stWorkerInputはプライマリディスプレイで最大化しておく

1. 自動実行スクリプトの生成とautoitの生成
  1. $ ruby code.rb

**code.rbを実行するとautoitも実行されます。自動実行が不要な場合はcode.rbの最後の行をコメントアウトしてください。**
