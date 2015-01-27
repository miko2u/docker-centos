# docker-centos

日本語環境の CentOS6 です。
これをベースに各コンテナを作成しています。

なぜ CentOS6 かというと、Dockerで複数サービス常駐するときは
sysvinit のほうが管理が楽かと思ったからです。

## 特徴

コンテナ内のサービスは sysvinit ベースにしているので、
バックグラウンドでしか動作しないものにも対応できたります。

仕組みとしては、bash の trap を利用して、

- コンテナ起動時に init 3
- コンテナ終了時に init 0

の仕組みを利用しています。

## 使い方

こんな感じで使用すると、サービスを起動しながら起動していきます。

```
docker create -it -h $(HOSTNAME).localdomain --name $(CONTAINER) miko2u/centos6
docker start $(CONTAINER)
```

bash のホームディレクトリが / なのが気になる方は以下を追加して下さい。

```
WORKDIR /root
ENV HOME /root
```

## 拡張

`/boot/prepare`のシェルスクリプトを用意すると起動前に実行できます。
これを利用して、Dockerの環境変数から設定ファイルを書き換えることなどに利用できます。

`/boot/post`のシェルスクリプトを用意すると起動後に実行できます。
これを利用して、起動後に実行したいこと等に利用できます。

## ToDo

本当は、bash trapの代わりにちゃんとしたinitを書きたかったのですが...
（sleepはプロセス起動のコストがイヤなので使わない）

ちなみに、このコンテナ作ってからsystemdを使わなくなっちゃいました(^^;

# LICENSE

MIT LICENSE

## AUTHORS

- Miko <miko@cafelounge.net>
