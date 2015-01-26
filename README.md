# docker-centos

日本語環境の CentOS6 です。
これをベースに各コンテナを作成しています。

なぜ CentOS6 にしているかというと、Dockerで複数サービス常駐するときは
sysvinit のほうが管理が楽かと思ったからです。
