# How to login remote host without password?

## Approach 1: Using ssh-keygen & ssh-copy-id

Public key authentication can allow you to log into remote systems via SSH without a password.  Even though you will not need a password to log into a system, you will need to have access to the key.  Be sure to keep your key in a secure location.

Here is an example of creating a passwordless connection from linuxsvr01 to linuxsvr02 using SSH public key authentication.
1. Create an SSH Key

Use the ssh-keygen command to create an SSH key.  Accept all the defaults by pressing ENTER at every prompt.  You’ll want to leave the passphrase empty.

```
linuxsvr01$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/user/.ssh/id_rsa.
Your public key has been saved in /home/user/.ssh/id_rsa.pub.
The key fingerprint is:
b2:ad:a0:80:85:ad:6c:16:bd:1c:e7:63:4f:a0:00:15 user@host
The key's randomart image is:
+---[RSA 2048]----+
|           . o + |
|         = X * . |
|      . O @ = . .|
|     + o X O . + |
|   . = S * = o   |
| . ..o . . o .   |
|     + .o. E     |
|      + ...o.    |
|     . . ooo+.   |
+----[SHA256]-----+
linuxsvr01$
```

Note: You can optionally add a passphrase for the key itself.  If you do use a passphrase, then you will have to use an ssh-agent to cache the passphrase.  While the passphrase is cached you can connect without entering in the passphrase.

2. Copy the SSH Public Key to the Remote Host

```
linuxsvr01$ ssh-copy-id root@linuxsvr02
root@linuxsvr02's password:
linuxsvr01$
```

3. Login to the Remote Host Without a Password

Now you can connect to the server without a password.

```
linuxsvr01$ ssh root@linuxsvr02
Last login: Tue Apr 22 11:35:41 2016 from 10.23.45.67
linuxsvr02#
```

## Approach 2: Generate Key and Copy to the Host to Login

Use the ssh-keygen command to create an SSH key.  Accept all the defaults by pressing ENTER at every prompt.  You’ll want to leave the passphrase empty.

```
wangxy@concerto:~$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/wangxy/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/wangxy/.ssh/id_rsa.
Your public key has been saved in /home/wangxy/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:qxCSp55uDL6q1VbMiqAArjvA6vZVZK3EXo3uqLp3taQ wangxy@concerto
The key's randomart image is:
+---[RSA 2048]----+
|                 |
|      . . o      |
|.      = + .     |
|o  . o= +        |
|+.o o ++S.       |
|*o * +. o+       |
|*o+ =. .=..      |
|o*oo.o.E .       |
|O**++.o          |
+----[SHA256]-----+
wangxy@concerto:~$ ssh master@192.168.0.161 mkdir -p .ssh
master@192.168.0.161's password: 
wangxy@concerto:~$ cat .ssh/id_rsa.pub | ssh master@192.168.0.161 'cat >> .ssh/authorized_keys'
master@192.168.0.161's password: 
wangxy@concerto:~$ ssh master@192.168.0.161
Last login: Thu Jan 24 16:28:38 2019 from 192.168.0.78
[master@repository ~]$ exit
logout
Connection to 192.168.0.161 closed.
wangxy@concerto:~$ 
```

