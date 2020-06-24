
# Linuxカーネルにrubyイメージを導入
FROM ruby:2.5.1

# gemの起動にJavaが必要なため、設定を行う
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# dockerはlinuxカーネルを軸に動作するので、環境構築に必要なパッケージはapt-getでインストール
RUN apt-get update && \
    apt-get install -y curl wget openjdk-8-jdk  && \
    apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリの作成（myappの元でrails newされるため、これがアプリ名になる）
# Gemfileの中身は適宜変更
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
# railsの場合、pidファイルがあるとエラーを起こす原因となるため、shを読み込む
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# rails server -b 0.0.0.0 と同じ
# サーバーを起動すると、起動したPCに関連するIPアドレスでLAN上の他の端末からアクセスすることができる
CMD ["rails", "server", "-b", "0.0.0.0"]
