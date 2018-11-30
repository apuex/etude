# SSL How-to 

## Create cert db & cert

```
$ mkdir cert
$ cd cert
cert$ ~/MessageQueue5.1/nss/bin/64/certutil -N -d . 
Enter Password or Pin for "NSS Certificate DB":
Invalid password.  Try again.
Enter Password or Pin for "NSS Certificate DB":
Enter a password which will be used to encrypt your keys.
The password should be at least 8 characters long,
and should contain at least one non-alphabetic character.

Enter new password: 
Re-enter password: 
Password changed successfully.
cert$ cd ..
$
```

## Set connection properties.

Add these lines prior to creation connection.

```
  MQ_ERR_CHK( MQSetStringProperty(propertiesHandle,
                                  MQ_CONNECTION_TYPE_PROPERTY, "SSL") );
  MQ_ERR_CHK( MQSetBoolProperty(propertiesHandle,
                                  MQ_SSL_BROKER_IS_TRUSTED, 1) );

  ConstMQString certPath = "cert";
  
  MQ_ERR_CHK( MQInitializeSSL(certPath) );
```

## Enable ssljms connector

### Create keystore using imqkeytool

```
imqkeytool -broker
```

### Configure keystore and passfile

Edit <IMQ_HOME>mq/lib/props/broker/default.properties

```
# configuration for the keystore used by the ssl service
imq.keystore.file.dirpath=${imq.etchome}
imq.keystore.file.name=keystore

# location of the passfile to be used for all passwords
imq.passfile.enabled=true
imq.passfile.dirpath=${imq.etchome}
imq.passfile.name=passfile
```

### Enable ssljms

Edit <IMQ_HOME>mq/lib/props/broker/default.properties


```
# List of active services, started at startup
imq.service.activelist=jms,admin,ssljms
```

### Start broker and check ssl connector status

```
$ nohup bin/imqbrokerd &> /dev/null &
$ imqcmd list svc -b 192.168.0.78 -u admin
Password: 
Listing all the services on the broker specified by:

----------------------------
Host            Primary Port
----------------------------
192.168.0.78    7676

------------------------------------------------
Service Name    Port Number        Service State
------------------------------------------------
admin           38596 (dynamic)    RUNNING
httpjms         -                  UNKNOWN
httpsjms        -                  UNKNOWN
jms             7677 (static)      RUNNING
ssladmin        dynamic            UNKNOWN
ssljms          7678 (static)      RUNNING
wsjms           7670 (static)      UNKNOWN
wssjms          7671 (static)      UNKNOWN

Successfully listed services.
$
```

## Compile C code & Run

```
$ gcc -I/home/wangxy/MessageQueue5.1/mq/include/ -c Producer.c
$ gcc -L/home/wangxy/MessageQueue5.1/mq/lib64 -o producer Producer.o -lmqcrt
$ ./producer -h 192.168.0.78 -p 7676 -t q
    "Preparing for NSS initialization ..."
    "Initializing NSS ..."
    "Using 'cert' as the SSL certificate db directory."
    "SSL Using DOMESTIC cipher policy."
    "SSL reseting handshake."
    "SSL force handshake."
    "SSL certificate authentication rejected because SEC_ERROR_CA_CERT_INVALID, but trusting host anyway"
    "SSL host certificate verification succeeded."
    "Opened SSL connection to broker 192.168.0.78:7678."
    "Connection ping enabled (ping interval = 30 second)."
    "Connection connected to broker"
Enter a message to send:
Hello
Sending message: World
^C
$

```

