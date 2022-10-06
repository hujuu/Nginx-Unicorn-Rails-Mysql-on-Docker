FROM --platform=linux/x86_64 ruby:3.1
LABEL maintainer="Munetake_Miguchi<guchim1229@gmail.com>"

#環境変数
ENV APP="/myapp-miguchi"  \
        CONTAINER_ROOT="./" 

#ライブラリのインストール
RUN apt-get update && apt-get install -y \
        nodejs \
        mariadb-client \
        build-essential \
        wget \
        yarn 

# 実行するディレクトリの指定
WORKDIR $APP
COPY Gemfile Gemfile.lock $CONTAINER_ROOT
RUN bundle install