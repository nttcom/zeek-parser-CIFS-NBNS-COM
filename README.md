# Zeek-Parser-CIFS-NBNS-COM

English is [here](https://github.com/nttcom/zeek-parser-NBNS/blob/main/README_en.md)

## 概要

Zeek-Parser-CIFS-NBNS-COMとはNetBios Protocolを解析できるZeekプラグインです。

## 使い方

### マニュアルインストール

本プラグインを利用する前に、Zeek, Spicyがインストールされていることを確認します。
```
# Zeekのチェック
~$ zeek -version
zeek version 5.0.0

# Spicyのチェック
~$ spicyz -version
1.3.16
~$ spicyc -version
spicyc v1.5.0 (d0bc6053)

# 本マニュアルではZeekのパスが以下であることを前提としています。
~$ which zeek
/usr/local/zeek/bin/zeek
```

本リポジトリをローカル環境に `git clone` します。
```
~$ git clone https://github.com/nttcom/zeek-parser-CIFS-NBNS-COM.git
```

ソースコードをコンパイルして、オブジェクトファイルを以下のパスにコピーします。
```
~$ cd ~/zeek-parser-CIFS-NBNS-COM/analyzer
~$ spicyz -o nbns.hlto nbns.spicy nbns.evt
# nbns.hltoが生成されます
~$ cp nbns.hlto /usr/local/zeek/lib/zeek-spicy/modules/
```

同様にZeekファイルを以下のパスにコピーします。
```
~$ cd ~/zeek-parser-CIFS-NBNS-COM/scripts/
~$ cp main.zeek /usr/local/zeek/share/zeek/site/
```

最後にZeekプラグインをインポートします。
```
~$ tail /usr/local/zeek/share/zeek/site/local.zeek
...省略...
@load NBNS
```

本プラグインを使うことで `nbns.log` が生成されます。
```
~$ cd ~/zeek-parser-CIFS-NBNS-COM/testing/Traces
~$ zeek -Cr test.pcap /usr/local/zeek/share/zeek/site/main.zeek
```

## ログのタイプと説明
本プラグインはnbnsの全ての関数を監視して`nbns.log`として出力します。

| フィールド | タイプ | 説明 |
| --- | --- | --- |
| ts | time | 通信した時のタイムスタンプ |
| SrcIP | addr | 送信元IPアドレス  |
| SrcMAC | string | 送信元MACアドレス |
| Name | string | デバイス名やモデル番号 |
| TTL | count | 生存時間（データの有効期限、破棄されるまでの残り時間） |
| ServerType | string | サーバーのタイプ |

`nbns.log` の例は以下のとおりです。
```
#separator \x09
#set_separator	,
#empty_field	(empty)
#unset_field	-
#path	nbns
#open	2023-09-13-04-00-57
#fields	ts	SrcIP	SrcMAC	Name	TTL	ServiceType
#types	time	addr	string	string	count	string
750820972.181240	192.168.1.215	3c:a6:f6:29:43:51	MACBOOKAIR-435	900	Server
750820972.171322	192.168.1.215	3c:a6:f6:29:43:51	MACBOOKAIR-435	900	Workstation
750823604.550596	192.168.1.215	3c:a6:f6:29:43:51	MACBOOKAIR-435	900	Server
#close	2023-09-13-04-00-57
```

## ソフトウェア

本プラグインは[OsecT](https://github.com/nttcom/OsecT)で利用されています。

