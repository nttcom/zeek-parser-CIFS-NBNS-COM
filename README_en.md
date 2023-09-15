# Zeek-Parser-CIFS-NBNS-COM

## Overview

Zeek-Parser-CIFS-NBNS-COM is a Zeek plug-in that can analyze communication using NetBios Protocol.

## Usage

### Manual Installation

Before using this plug-in, please make sure Zeek, Spicy has been installed.

````
# Check Zeek
~$ zeek -version
zeek version 5.0.0

# Check Spicy
~$ spicyz -version
1.3.16
~$ spicyc -version
spicyc v1.5.0 (d0bc6053)

# As a premise, the path of zeek in this manual is as below
~$ which zeek
/usr/local/zeek/bin/zeek
````

Use `git clone` to get a copy of this repository to your local environment.
```
~$ git clone https://github.com/nttcom/zeek-parser-CIFS-NBNS-COM.git
```

Compile source code and copy the object files to the following path.
```
~$ cd ~/zeek-parser-CIFS-NBNS-COM/analyzer
~$ spicyz -o nbns.hlto nbns.spicy nbns.evt
# nbns.hlto will be generated
~$ cp nbns.hlto /usr/local/zeek/lib/zeek-spicy/modules/
```

Then, copy the zeek file to the following paths.
```
~$ cd ~/zeek-parser-CIFS-NBNS-COM/scripts/
~$ cp main.zeek /usr/local/zeek/share/zeek/site/
```

Finally, import the Zeek plugin.
```
~$ tail /usr/local/zeek/share/zeek/site/local.zeek
... Omit ...
@load NBNS
```

This plug-in generates a `nbns.log` by the command below:
```
~$ cd ~/zeek-parser-CIFS-NBNS-COM/testing/Traces
~$ zeek -Cr test.pcap /usr/local/zeek/share/zeek/site/main.zeek
```

## Log type and description
This plug-in monitors all functions of nbns and outputs them as `nbns.log`.

| Field | Type | Description |
| --- | --- | --- |
| ts | time | timestamp of the communication |
| SrcIP | addr | source IP address  |
| SrcMAC | string | source MAC address |
| Name | string | device name or model number |
| TTL | count | time to live |
| ServerType | string | type of the server |

An example of `nbns.log` is as follows:
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

## Related Software

This plug-in is used by [OsecT](https://github.com/nttcom/OsecT).


