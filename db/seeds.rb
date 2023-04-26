# frozen_string_literal: true

learning_gnu_emacs_authors = Author.create([{ name: 'Debra Cameron' }, { name: 'James Elliott' }, { name: 'Marc Loy' },
                                            { name: 'Eric Raymond' }, { name: 'Bill Rosenblatt' }, { name: '宮下 尚' },
                                            { name: '半田 剣一' }, { name: '新井 貴之' }, { name: '鈴木 和也' }])

description = <<~DESCRIPTION
  20年以上の歴史を持つ人気エディタのEmacs。
  当初はUnix上でしか使うことができなかったEmacsですが、現在ではUnix/LinuxだけでなくWindowsやMac OS Xでも使われています。
  本書には、アイコンベースのツールバーなどEmacs 21以降で使えるようになった新しい機能の解説をはじめ、進化を続けるEmacsを効果的に使うためのTIPSが含まれています。
  これからEmacsを使いはじめる方だけでなく、パワーユーザにもお勧めです。
  知らなかった基本機能がきっと見つかるでしょう。
DESCRIPTION

learning_gnu_emacs_book = Book.create(title: '入門 GNU Emacs 第3版',
                                      description:, page: 512, isbn: '4798124702')
learning_gnu_emacs_authors.each do |author|
  BookAuthor.create(book: learning_gnu_emacs_book, author:)
end

pro_ruby_auther = Author.create(name: '伊藤 淳一')

description = <<~DESCRIPTION
  Railsをやる前に、Rubyを知ろう

  Rubyの文法をサンプルコードで学び、例題でプログラミングの流れを体験できる解説書です。
  ほかのプログラミング言語で開発経験のある人が、Rubyを学ぶ際に効率的に学べる内容を詰め込みました。
  プログラミング未経験者向けの「変数とは」「配列とは」といったプログラミング基礎知識の説明は最小限にし、
  そのぶんRubyの特徴(他プログラミング言語との違い)、
  Rubyにおけるリファクタリングの要点、テスト駆動開発やデバッグのやり方など開発現場で必要になる知識を解説しています。
  本書の内容を理解すれば、開発の現場で必要とされるRuby関連の知識を一通り習得できます。
  そして、「今まで呪文のようにしか見えなかった不思議な構文」や
  「実はあまりよくわからないまま、見よう見まねで書いているコード」も自信をもって読み書きできるようになるはずです。
  本書はRuby 2.4をベースに解説します。Ruby 2.2や2.3など、少し前のバージョンで動きが異なる場合は、適宜注釈を入れています。
DESCRIPTION

pro_ruby_book = Book.create(title: 'プロを目指す人のためのRuby入門 言語仕様からテスト駆動開発・デバッグ技法まで Software Design plus',
                            description:, page: 472, isbn: '4774193976')
BookAuthor.create(book: pro_ruby_book, author: pro_ruby_auther)
