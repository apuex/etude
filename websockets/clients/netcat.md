```
$ netcat 192.168.0.184 8000 | hexdump -C
GET /api/events HTTP/1.1
Host: 192.168.0.184:8000
Sec-WebSocket-Version: 13
Origin: http://192.168.0.184:8000
Sec-WebSocket-Key: gUgMwGFIDIoUKMk7YWB58g==
Connection: keep-alive, Upgrade
Upgrade: websocket

00000000  48 54 54 50 2f 31 2e 31  20 31 30 31 20 53 77 69  |HTTP/1.1 101 Swi|
00000010  74 63 68 69 6e 67 20 50  72 6f 74 6f 63 6f 6c 73  |tching Protocols|
00000020  0d 0a 55 70 67 72 61 64  65 3a 20 77 65 62 73 6f  |..Upgrade: webso|
00000030  63 6b 65 74 0d 0a 53 65  63 2d 57 65 62 53 6f 63  |cket..Sec-WebSoc|
00000040  6b 65 74 2d 41 63 63 65  70 74 3a 20 48 39 66 72  |ket-Accept: H9fr|
00000050  39 51 4c 56 45 51 69 55  78 6c 6d 47 32 41 2b 4c  |9QLVEQiUxlmG2A+L|
00000060  74 36 62 77 46 5a 4d 3d  0d 0a 44 61 74 65 3a 20  |t6bwFZM=..Date: |
00000070  54 75 65 2c 20 32 36 20  4e 6f 76 20 32 30 31 39  |Tue, 26 Nov 2019|
00000080  20 30 32 3a 32 32 3a 33  35 20 47 4d 54 0d 0a 43  | 02:22:35 GMT..C|
00000090  6f 6e 6e 65 63 74 69 6f  6e 3a 20 75 70 67 72 61  |onnection: upgra|
000000a0  64 65 0d 0a 0d 0a 81 7e  00 d5 7b 22 6f 66 66 73  |de.....~..{"offs|
000000b0  65 74 22 3a 22 31 22 2c  22 70 65 72 73 69 73 74  |et":"1","persist|
000000c0  65 6e 63 65 49 64 22 3a  22 68 65 6c 6c 6f 2d 31  |enceId":"hello-1|
000000d0  2e 30 2e 30 22 2c 22 73  65 71 75 65 6e 63 65 4e  |.0.0","sequenceN|
000000e0  72 22 3a 22 31 22 2c 22  65 76 65 6e 74 22 3a 7b  |r":"1","event":{|
000000f0  22 40 74 79 70 65 22 3a  22 74 79 70 65 2e 67 6f  |"@type":"type.go|
00000100  6f 67 6c 65 61 70 69 73  2e 63 6f 6d 2f 63 6f 6d  |ogleapis.com/com|
00000110  2e 65 78 61 6d 70 6c 65  2e 6c 65 76 65 6c 64 62  |.example.leveldb|
00000120  2e 53 61 79 48 65 6c 6c  6f 45 76 65 6e 74 22 2c  |.SayHelloEvent",|
00000130  22 74 6f 22 3a 22 48 65  6c 6c 6f 22 2c 22 6d 65  |"to":"Hello","me|
00000140  73 73 61 67 65 22 3a 22  48 65 6c 6c 6f 2c 20 48  |ssage":"Hello, H|
00000150  65 6c 6c 6f 21 5c 6e 5c  74 2d 2d 20 41 20 77 61  |ello!\n\t-- A wa|
00000160  72 6d 20 77 65 6c 63 6f  6d 65 20 66 72 6f 6d 20  |rm welcome from |
00000170  68 65 6c 6c 6f 2d 31 2e  30 2e 30 2e 22 7d 7d 81  |hello-1.0.0."}}.|
00000180  7e 00 d1 7b 22 6f 66 66  73 65 74 22 3a 22 32 22  |~..{"offset":"2"|
00000190  2c 22 70 65 72 73 69 73  74 65 6e 63 65 49 64 22  |,"persistenceId"|
000001a0  3a 22 68 65 6c 6c 6f 2d  31 2e 30 2e 30 22 2c 22  |:"hello-1.0.0","|
000001b0  73 65 71 75 65 6e 63 65  4e 72 22 3a 22 32 22 2c  |sequenceNr":"2",|
000001c0  22 65 76 65 6e 74 22 3a  7b 22 40 74 79 70 65 22  |"event":{"@type"|
000001d0  3a 22 74 79 70 65 2e 67  6f 6f 67 6c 65 61 70 69  |:"type.googleapi|
000001e0  73 2e 63 6f 6d 2f 63 6f  6d 2e 65 78 61 6d 70 6c  |s.com/com.exampl|
000001f0  65 2e 6c 65 76 65 6c 64  62 2e 53 61 79 48 65 6c  |e.leveldb.SayHel|
00000200  6c 6f 45 76 65 6e 74 22  2c 22 74 6f 22 3a 22 79  |loEvent","to":"y|
00000210  45 53 22 2c 22 6d 65 73  73 61 67 65 22 3a 22 48  |ES","message":"H|
00000220  65 6c 6c 6f 2c 20 79 45  53 21 5c 6e 5c 74 2d 2d  |ello, yES!\n\t--|
00000230  20 41 20 77 61 72 6d 20  77 65 6c 63 6f 6d 65 20  | A warm welcome |
00000240  66 72 6f 6d 20 68 65 6c  6c 6f 2d 31 2e 30 2e 30  |from hello-1.0.0|
00000250  2e 22 7d 7d 81 7e 00 d1  7b 22 6f 66 66 73 65 74  |."}}.~..{"offset|
00000260  22 3a 22 33 22 2c 22 70  65 72 73 69 73 74 65 6e  |":"3","persisten|
00000270  63 65 49 64 22 3a 22 68  65 6c 6c 6f 2d 31 2e 30  |ceId":"hello-1.0|
00000280  2e 30 22 2c 22 73 65 71  75 65 6e 63 65 4e 72 22  |.0","sequenceNr"|
00000290  3a 22 33 22 2c 22 65 76  65 6e 74 22 3a 7b 22 40  |:"3","event":{"@|
000002a0  74 79 70 65 22 3a 22 74  79 70 65 2e 67 6f 6f 67  |type":"type.goog|
000002b0  6c 65 61 70 69 73 2e 63  6f 6d 2f 63 6f 6d 2e 65  |leapis.com/com.e|
000002c0  78 61 6d 70 6c 65 2e 6c  65 76 65 6c 64 62 2e 53  |xample.leveldb.S|
000002d0  61 79 48 65 6c 6c 6f 45  76 65 6e 74 22 2c 22 74  |ayHelloEvent","t|
000002e0  6f 22 3a 22 79 45 53 22  2c 22 6d 65 73 73 61 67  |o":"yES","messag|
000002f0  65 22 3a 22 48 65 6c 6c  6f 2c 20 79 45 53 21 5c  |e":"Hello, yES!\|
00000300  6e 5c 74 2d 2d 20 41 20  77 61 72 6d 20 77 65 6c  |n\t-- A warm wel|
00000310  63 6f 6d 65 20 66 72 6f  6d 20 68 65 6c 6c 6f 2d  |come from hello-|
00000320  31 2e 30 2e 30 2e 22 7d  7d 81 7e 00 d1 7b 22 6f  |1.0.0."}}.~..{"o|
00000330  66 66 73 65 74 22 3a 22  34 22 2c 22 70 65 72 73  |ffset":"4","pers|
00000340  69 73 74 65 6e 63 65 49  64 22 3a 22 68 65 6c 6c  |istenceId":"hell|
00000350  6f 2d 31 2e 30 2e 30 22  2c 22 73 65 71 75 65 6e  |o-1.0.0","sequen|
00000360  63 65 4e 72 22 3a 22 34  22 2c 22 65 76 65 6e 74  |ceNr":"4","event|
00000370  22 3a 7b 22 40 74 79 70  65 22 3a 22 74 79 70 65  |":{"@type":"type|
00000380  2e 67 6f 6f 67 6c 65 61  70 69 73 2e 63 6f 6d 2f  |.googleapis.com/|
00000390  63 6f 6d 2e 65 78 61 6d  70 6c 65 2e 6c 65 76 65  |com.example.leve|
000003a0  6c 64 62 2e 53 61 79 48  65 6c 6c 6f 45 76 65 6e  |ldb.SayHelloEven|
000003b0  74 22 2c 22 74 6f 22 3a  22 79 45 53 22 2c 22 6d  |t","to":"yES","m|
000003c0  65 73 73 61 67 65 22 3a  22 48 65 6c 6c 6f 2c 20  |essage":"Hello, |
000003d0  79 45 53 21 5c 6e 5c 74  2d 2d 20 41 20 77 61 72  |yES!\n\t-- A war|
000003e0  6d 20 77 65 6c 63 6f 6d  65 20 66 72 6f 6d 20 68  |m welcome from h|
000003f0  65 6c 6c 6f 2d 31 2e 30  2e 30 2e 22 7d 7d 81 7e  |ello-1.0.0."}}.~|
00000400  00 d1 7b 22 6f 66 66 73  65 74 22 3a 22 35 22 2c  |..{"offset":"5",|
00000410  22 70 65 72 73 69 73 74  65 6e 63 65 49 64 22 3a  |"persistenceId":|
00000420  22 68 65 6c 6c 6f 2d 31  2e 30 2e 30 22 2c 22 73  |"hello-1.0.0","s|
00000430  65 71 75 65 6e 63 65 4e  72 22 3a 22 35 22 2c 22  |equenceNr":"5","|
00000440  65 76 65 6e 74 22 3a 7b  22 40 74 79 70 65 22 3a  |event":{"@type":|
00000450  22 74 79 70 65 2e 67 6f  6f 67 6c 65 61 70 69 73  |"type.googleapis|
00000460  2e 63 6f 6d 2f 63 6f 6d  2e 65 78 61 6d 70 6c 65  |.com/com.example|
00000470  2e 6c 65 76 65 6c 64 62  2e 53 61 79 48 65 6c 6c  |.leveldb.SayHell|
00000480  6f 45 76 65 6e 74 22 2c  22 74 6f 22 3a 22 79 45  |oEvent","to":"yE|
00000490  53 22 2c 22 6d 65 73 73  61 67 65 22 3a 22 48 65  |S","message":"He|
000004a0  6c 6c 6f 2c 20 79 45 53  21 5c 6e 5c 74 2d 2d 20  |llo, yES!\n\t-- |
000004b0  41 20 77 61 72 6d 20 77  65 6c 63 6f 6d 65 20 66  |A warm welcome f|
000004c0  72 6f 6d 20 68 65 6c 6c  6f 2d 31 2e 30 2e 30 2e  |rom hello-1.0.0.|
000004d0  22 7d 7d 81 7e 00 d1 7b  22 6f 66 66 73 65 74 22  |"}}.~..{"offset"|
000004e0  3a 22 36 22 2c 22 70 65  72 73 69 73 74 65 6e 63  |:"6","persistenc|
000004f0  65 49 64 22 3a 22 68 65  6c 6c 6f 2d 31 2e 30 2e  |eId":"hello-1.0.|
00000500  30 22 2c 22 73 65 71 75  65 6e 63 65 4e 72 22 3a  |0","sequenceNr":|
00000510  22 36 22 2c 22 65 76 65  6e 74 22 3a 7b 22 40 74  |"6","event":{"@t|
00000520  79 70 65 22 3a 22 74 79  70 65 2e 67 6f 6f 67 6c  |ype":"type.googl|
00000530  65 61 70 69 73 2e 63 6f  6d 2f 63 6f 6d 2e 65 78  |eapis.com/com.ex|
00000540  61 6d 70 6c 65 2e 6c 65  76 65 6c 64 62 2e 53 61  |ample.leveldb.Sa|
00000550  79 48 65 6c 6c 6f 45 76  65 6e 74 22 2c 22 74 6f  |yHelloEvent","to|
00000560  22 3a 22 79 45 53 22 2c  22 6d 65 73 73 61 67 65  |":"yES","message|
00000570  22 3a 22 48 65 6c 6c 6f  2c 20 79 45 53 21 5c 6e  |":"Hello, yES!\n|
00000580  5c 74 2d 2d 20 41 20 77  61 72 6d 20 77 65 6c 63  |\t-- A warm welc|
00000590  6f 6d 65 20 66 72 6f 6d  20 68 65 6c 6c 6f 2d 31  |ome from hello-1|
000005a0  2e 30 2e 30 2e 22 7d 7d  81 7e 00 d1 7b 22 6f 66  |.0.0."}}.~..{"of|
000005b0  66 73 65 74 22 3a 22 37  22 2c 22 70 65 72 73 69  |fset":"7","persi|
000005c0  73 74 65 6e 63 65 49 64  22 3a 22 68 65 6c 6c 6f  |stenceId":"hello|
000005d0  2d 31 2e 30 2e 30 22 2c  22 73 65 71 75 65 6e 63  |-1.0.0","sequenc|
000005e0  65 4e 72 22 3a 22 37 22  2c 22 65 76 65 6e 74 22  |eNr":"7","event"|
000005f0  3a 7b 22 40 74 79 70 65  22 3a 22 74 79 70 65 2e  |:{"@type":"type.|
00000600  67 6f 6f 67 6c 65 61 70  69 73 2e 63 6f 6d 2f 63  |googleapis.com/c|
00000610  6f 6d 2e 65 78 61 6d 70  6c 65 2e 6c 65 76 65 6c  |om.example.level|
00000620  64 62 2e 53 61 79 48 65  6c 6c 6f 45 76 65 6e 74  |db.SayHelloEvent|
00000630  22 2c 22 74 6f 22 3a 22  79 45 53 22 2c 22 6d 65  |","to":"yES","me|
00000640  73 73 61 67 65 22 3a 22  48 65 6c 6c 6f 2c 20 79  |ssage":"Hello, y|
00000650  45 53 21 5c 6e 5c 74 2d  2d 20 41 20 77 61 72 6d  |ES!\n\t-- A warm|
00000660  20 77 65 6c 63 6f 6d 65  20 66 72 6f 6d 20 68 65  | welcome from he|
00000670  6c 6c 6f 2d 31 2e 30 2e  30 2e 22 7d 7d 81 7e 00  |llo-1.0.0."}}.~.|
00000680  d1 7b 22 6f 66 66 73 65  74 22 3a 22 38 22 2c 22  |.{"offset":"8","|
00000690  70 65 72 73 69 73 74 65  6e 63 65 49 64 22 3a 22  |persistenceId":"|
000006a0  68 65 6c 6c 6f 2d 31 2e  30 2e 30 22 2c 22 73 65  |hello-1.0.0","se|
000006b0  71 75 65 6e 63 65 4e 72  22 3a 22 38 22 2c 22 65  |quenceNr":"8","e|
000006c0  76 65 6e 74 22 3a 7b 22  40 74 79 70 65 22 3a 22  |vent":{"@type":"|
000006d0  74 79 70 65 2e 67 6f 6f  67 6c 65 61 70 69 73 2e  |type.googleapis.|
000006e0  63 6f 6d 2f 63 6f 6d 2e  65 78 61 6d 70 6c 65 2e  |com/com.example.|
000006f0  6c 65 76 65 6c 64 62 2e  53 61 79 48 65 6c 6c 6f  |leveldb.SayHello|
00000700  45 76 65 6e 74 22 2c 22  74 6f 22 3a 22 79 45 53  |Event","to":"yES|
00000710  22 2c 22 6d 65 73 73 61  67 65 22 3a 22 48 65 6c  |","message":"Hel|
00000720  6c 6f 2c 20 79 45 53 21  5c 6e 5c 74 2d 2d 20 41  |lo, yES!\n\t-- A|
00000730  20 77 61 72 6d 20 77 65  6c 63 6f 6d 65 20 66 72  | warm welcome fr|
00000740  6f 6d 20 68 65 6c 6c 6f  2d 31 2e 30 2e 30 2e 22  |om hello-1.0.0."|
00000750  7d 7d 81 7e 00 d1 7b 22  6f 66 66 73 65 74 22 3a  |}}.~..{"offset":|
00000760  22 39 22 2c 22 70 65 72  73 69 73 74 65 6e 63 65  |"9","persistence|
00000770  49 64 22 3a 22 68 65 6c  6c 6f 2d 31 2e 30 2e 30  |Id":"hello-1.0.0|
00000780  22 2c 22 73 65 71 75 65  6e 63 65 4e 72 22 3a 22  |","sequenceNr":"|
00000790  39 22 2c 22 65 76 65 6e  74 22 3a 7b 22 40 74 79  |9","event":{"@ty|
000007a0  70 65 22 3a 22 74 79 70  65 2e 67 6f 6f 67 6c 65  |pe":"type.google|
000007b0  61 70 69 73 2e 63 6f 6d  2f 63 6f 6d 2e 65 78 61  |apis.com/com.exa|
000007c0  6d 70 6c 65 2e 6c 65 76  65 6c 64 62 2e 53 61 79  |mple.leveldb.Say|
000007d0  48 65 6c 6c 6f 45 76 65  6e 74 22 2c 22 74 6f 22  |HelloEvent","to"|
000007e0  3a 22 79 45 53 22 2c 22  6d 65 73 73 61 67 65 22  |:"yES","message"|
000007f0  3a 22 48 65 6c 6c 6f 2c  20 79 45 53 21 5c 6e 5c  |:"Hello, yES!\n\|
00000800  74 2d 2d 20 41 20 77 61  72 6d 20 77 65 6c 63 6f  |t-- A warm welco|
00000810  6d 65 20 66 72 6f 6d 20  68 65 6c 6c 6f 2d 31 2e  |me from hello-1.|
00000820  30 2e 30 2e 22 7d 7d 81  7e 00 d3 7b 22 6f 66 66  |0.0."}}.~..{"off|
00000830  73 65 74 22 3a 22 31 30  22 2c 22 70 65 72 73 69  |set":"10","persi|
00000840  73 74 65 6e 63 65 49 64  22 3a 22 68 65 6c 6c 6f  |stenceId":"hello|
00000850  2d 31 2e 30 2e 30 22 2c  22 73 65 71 75 65 6e 63  |-1.0.0","sequenc|
00000860  65 4e 72 22 3a 22 31 30  22 2c 22 65 76 65 6e 74  |eNr":"10","event|
00000870  22 3a 7b 22 40 74 79 70  65 22 3a 22 74 79 70 65  |":{"@type":"type|
00000880  2e 67 6f 6f 67 6c 65 61  70 69 73 2e 63 6f 6d 2f  |.googleapis.com/|
00000890  63 6f 6d 2e 65 78 61 6d  70 6c 65 2e 6c 65 76 65  |com.example.leve|
000008a0  6c 64 62 2e 53 61 79 48  65 6c 6c 6f 45 76 65 6e  |ldb.SayHelloEven|
000008b0  74 22 2c 22 74 6f 22 3a  22 79 45 53 22 2c 22 6d  |t","to":"yES","m|
000008c0  65 73 73 61 67 65 22 3a  22 48 65 6c 6c 6f 2c 20  |essage":"Hello, |
000008d0  79 45 53 21 5c 6e 5c 74  2d 2d 20 41 20 77 61 72  |yES!\n\t-- A war|
000008e0  6d 20 77 65 6c 63 6f 6d  65 20 66 72 6f 6d 20 68  |m welcome from h|
000008f0  65 6c 6c 6f 2d 31 2e 30  2e 30 2e 22 7d 7d 81 7e  |ello-1.0.0."}}.~|
00000900  00 d3 7b 22 6f 66 66 73  65 74 22 3a 22 31 31 22  |..{"offset":"11"|
00000910  2c 22 70 65 72 73 69 73  74 65 6e 63 65 49 64 22  |,"persistenceId"|
00000920  3a 22 68 65 6c 6c 6f 2d  31 2e 30 2e 30 22 2c 22  |:"hello-1.0.0","|
00000930  73 65 71 75 65 6e 63 65  4e 72 22 3a 22 31 31 22  |sequenceNr":"11"|
00000940  2c 22 65 76 65 6e 74 22  3a 7b 22 40 74 79 70 65  |,"event":{"@type|
00000950  22 3a 22 74 79 70 65 2e  67 6f 6f 67 6c 65 61 70  |":"type.googleap|
00000960  69 73 2e 63 6f 6d 2f 63  6f 6d 2e 65 78 61 6d 70  |is.com/com.examp|
00000970  6c 65 2e 6c 65 76 65 6c  64 62 2e 53 61 79 48 65  |le.leveldb.SayHe|
00000980  6c 6c 6f 45 76 65 6e 74  22 2c 22 74 6f 22 3a 22  |lloEvent","to":"|
00000990  79 45 53 22 2c 22 6d 65  73 73 61 67 65 22 3a 22  |yES","message":"|
000009a0  48 65 6c 6c 6f 2c 20 79  45 53 21 5c 6e 5c 74 2d  |Hello, yES!\n\t-|
000009b0  2d 20 41 20 77 61 72 6d  20 77 65 6c 63 6f 6d 65  |- A warm welcome|
000009c0  20 66 72 6f 6d 20 68 65  6c 6c 6f 2d 31 2e 30 2e  | from hello-1.0.|
000009d0  30 2e 22 7d 7d                                    |0."}}|
000009d5
```

