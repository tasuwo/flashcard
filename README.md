# FlashCard

## これはなに

自分用に作ってみた単語帳アプリ．
macOS App をつくる練習用．
[tasuwo/FlashCardApp: A simple flash-card app for macOS](https://github.com/tasuwo/FlashCardApp) を作り直したもの．

## TODO

### 使い勝手を悪くしているもの

### なくてもとりあえず良いけどあったらいいなと思うもの

- カードホルダーの追加/編集/削除が行える
  - 追加ボタン押下時にカードホルダーの名前入力ウインドウを表示
    - キャンセル，決定ボタンを追加
    - キャンセルボタン押下時はウインドウを閉じる
    - 決定ボタン押下時はカードホルダーを追加する
      - nits: 空文字は指定できないようにする
      - nits: 同じ名前がある時は警告する
  - 削除ボタン押下時，削除処理を行う．選択されたカードホルダーを削除する
    - カードも一緒に削除する

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
