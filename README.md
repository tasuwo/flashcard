# Roadmap

## 使い勝手を悪くしているもの

## なくてもとりあえず良いけどあったらいいなと思うもの

- カードホルダーの追加/編集/削除が行える
- カードホルダーを指定して単語を追加できる
  - 検索時にタグ付けを行うことで可能にする(#holde_name みたいな)
  - デフォルト holder を設定画面で設定できるようにする
    - リストボックス選択時に設定(AppSettings)を更新する
    - リストボックスに既存の設定を反映させる
    - カード保存時に保存先をデフォルトフォルダーにする

- 学習スコアを記述する
  - Score
    - 学習日時
    - 正誤
  - CardHolder has many Card, Card has many Score

- 辞書の内容からコピペして来たい時がある

## どうでもいいもの

- 単語帳プレイの UI は，単語帳の形をしている必要性は皆無なので，一枚のボードに変更しても良いかも
- わかったかわからなかったかは矢印キーでフリップして答えられると良いかも
