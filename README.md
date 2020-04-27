# djangogirls-tutorial-docker
Django GirlsチュートリアルのアプリをDockerで動かしてみる。

# 使い方

## ビルド
```shell
docker build -t my-djangogirls-tutorial:1.0 .
```

## コンテナ起動
```shell
docker run -it -d -p 8000:8000 -v $(pwd):/root/djangogirls-tutorial --name my-djangogirls-tutorial my-djangogirls-tutorial:1.0
```

## ログイン
```shell
docker exec -it my-djangogirls-tutorial /bin/bash
```