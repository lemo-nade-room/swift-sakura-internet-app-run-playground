## バージョン

- Swift 6.2.1
- OpenTofu 1.10.8
- usacloud 1.19.3

## 前提条件

- APIキーを発行し、`usacloud config`を設定済み

## 料金

コンテナレジストリ:

- ストレージ5GiB/1レジストリ: 220円/月

```shell
docker buildx build -f Infra/Sakura/App/Dockerfile .
```

ログとメトリクスはコントロールパネルから初回に有効化する必要がある
https://secure.sakura.ad.jp/apprun/shared/applications
