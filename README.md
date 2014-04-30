auto-workerinput
================
# 概要
工数入力をできるだけ自動化します。
あくまで、できるだけ、です、作る手間も惜しみます。


# 必要なもの
1. Excel
2. ruby
3. auto it (http://www.autoitscript.com/site/autoit/)

# 前提
 * 毎日、1日中同じ業務だけやってるのが前提です。
 * 下記の4.は画面のサイズによってスクリプトの修正が必要です。code.rbの最後にスクリプトがあるので適宜修正してください。

# 手順
1.入力データの準備、作成
	1.きんのすけから出勤簿のEXCELをダウンロード
	2.きんのすけTo1stWorker.xlsxのWorkSheetに貼り付ける
	3. 1stWorkerシートからデータをTSVファイルにコピペ(works.tsv)
2.自動実行スクリプトの生成
	1. $ ruby code.rb > run.au3
3.1stWorkerInputを起動
	1. 起動したら工数入力画面を開く
	2. プロジェクトとタスクを選択
	3. 1stWorkerInputはプライマリディスプレイで最大化しておく
4.実行
	1. run.au3をautoitで実行

