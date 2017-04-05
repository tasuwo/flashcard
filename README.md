# FlashCard

## これはなに

自分用に作ってみた単語帳アプリ．
macOS App をつくる練習用．
[tasuwo/FlashCardApp: A simple flash-card app for macOS](https://github.com/tasuwo/FlashCardApp) を作り直したもの．

## TODO

### 使い勝手を悪くしているもの

- UserDefault に保存しているデフォルトカードホルダーのIDの検証が行われていない

### なくてもとりあえず良いけどあったらいいなと思うもの

- カードホルダーの追加/編集/削除が行える
  - 追加ボタン押下時にカードホルダーを追加する
    - 追加後，自動的に追加したカードホルダーのセルにフォーカスする

- 学習スコアを記述する
  - Score
    - 学習日時
    - 正誤
  - CardHolder has many Card, Card has many Score

- 辞書の内容からコピペして来たい時がある

## どうでもいいもの

- 単語帳プレイの UI は，単語帳の形をしている必要性は皆無なので，一枚のボードに変更しても良いかも
- わかったかわからなかったかは矢印キーでフリップして答えられると良いかも
- 検索時にタグ付けを行うことですきなカードホルダーに保存できる(#holde_name みたいな)
- カードホルダーを0個にはできないようにする
