# Week 11 - Public-Key Infrastructure (PKI)

## DNS Setup

As mentioned in the guide we needed to set up an HTTPS web server with the name of our choice, to do this we added the following entries to `/etc/hosts`:

```console
# For PKI Lab
10.9.0.80        www.bank32.com
10.9.0.80        www.l12g06.com
```

## Task 1 : Becoming a Certificate Authority (CA)

> A *CA* is a trusted entity that issues digital certificates, these certify the ownership of a public key by the named subject of the certificate

In this task we will make ourselves a root CA *(the certificates are self-signed and usually pre-loaded into most os's, web browsers and software that relies on PKI)*

`Root CA's are unconditionally trusted`

### Configuration

In order to use **OpenSSL** to create certificates we need to have a configuration file.
The default *.conf* file is located in `/usr/lib/ssl/openssl.cnf`. We will copy into our current directory using the following command:

```bash
$ cp /usr/lib/ssl/openssl.cnf newopenssl.cnf
```

Upon opening the file, we are met with Default CA settings:

```conf
####################################################################
[ ca ]
default_ca	= CA_default		# The default ca section

####################################################################
[ CA_default ]

dir		= ./demoCA		# Where everything is kept
certs		= $dir/certs		# Where the issued certs are kept
crl_dir		= $dir/crl		# Where the issued crl are kept
database	= $dir/index.txt	# database index file.
#unique_subject	= no			# Set to 'no' to allow creation of
					# several certs with same subject.
new_certs_dir	= $dir/newcerts		# default place for new certs.

certificate	= $dir/cacert.pem 	# The CA certificate
serial		= $dir/serial 		# The current serial number
```

We uncomment the *unique_subject* line to allow the creation of certification with the same subject, as suggested in the guide.

Yielding to the instructions in the guide we need to create several sub-directories, so we start by creating a directory that will house the files that we need to create, aka the *dir* in the CA_default

```bash
$ mkdir demoCA
```

Inside it we make another directory, this time the *new_certs_dir* in the CA_default.

```bash
$ mkdir demoCA/newcerts
```
Then we create the *index.txt* file, an empty one at that.

```bash
$ touch demoCA/index.txt
```

For the *serial* file, we put a single number in string format in the file.

```bash
$ echo 1000 > demoCA/serial
```

### Generating Self-Signed Certificate

> As previously mentioned, this self-signed certificate for our CA, will mean that the CA is totally trusted and its certificate will serve as the root certificate.

To generate it we run the following:

```bash
$ openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -keyout ca.key -out ca.crt
```

In our terminal we received the prompt `Enter PEM pass phrase:`, which we decided to just used our group identification (*l12g06*)

It's important to not lose this password since we will need to type it each time we want to use this CA to sign certificates for others.

Then we received the following prompts, and answered as follows:

```console
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:PT
State or Province Name (full name) [Some-State]:Porto
Locality Name (eg, city) []:Paranhos
Organization Name (eg, company) [Internet Widgits Pty Ltd]:FEUP
Organizational Unit Name (eg, section) []:FSI_23-24
Common Name (e.g. server FQDN or YOUR name) []:FSI
Email Address []:.
```

- After this, in our directory we got 2 new files:
  - *`ca.key`* -> contains the CA's private key
  - *`ca.crt`* -> contains the public-key certificate

We then used the following commands to look ar the decoded content of the X509 certificate and the RSA key

```bash
$ openssl x509 -in ca.crt -text -noout
$ openssl rsa -in ca.key -text -noout
```

*Note*: `-text` means decoding the content into plain text; `-noout` means not printing out the encoded version

The output of both [*ca.crt*](/week11-extras/task1/ca.crt.txt) and [*ca.key*](/week11-extras/task1/ca.key.txt) can be found in the [task1 folder](/week11-extras/task1/)
The guide prompted us the following questions:

#### What part of the certificate indicates this is a CA's certificate?

- In the output of the *ca.crt* we got:

```console
        X509v3 extensions:
            X509v3 Subject Key Identifier: 
                AC:11:73:C9:9B:5F:96:55:23:63:46:D3:76:54:E4:ED:4E:DC:56:6D
            X509v3 Authority Key Identifier: 
                keyid:AC:11:73:C9:9B:5F:96:55:23:63:46:D3:76:54:E4:ED:4E:DC:56:6D

            X509v3 Basic Constraints: critical
                CA:TRUE
    Signature Algorithm: sha256WithRSAEncryption
```

The `CA:TRUE` indicating that this is a CA's certificate.

#### What part of the certificate indicates this is a self-signed certificate?

- By looking at the output provided in the [question before](#what-part-of-the-certificate-indicates-this-is-a-cas-certificate), we can see that the *Subject Key Identifier* and the *Authority Key Identifier* are equal, therefore this certificate is a self-signed one

#### In the RSA algorithm, we have a public exponent e, a private exponent d, a modulus n, and two secret numbers p and q, such that n = pq. Please identify the values for these elements in your certificate and key files.

- The public exponent `e`:

```console
publicExponent: 65537 (0x10001)
```

- The private exponent `d`:

```console
privateExponent:
    1f:ef:1f:5e:48:c5:14:fa:88:0a:92:42:d5:37:38:
    61:2d:89:43:b4:4a:7e:13:dd:bd:d3:01:be:e0:d6:
    27:2e:91:5d:14:01:7b:04:b8:76:ee:f8:82:6c:7d:
    29:ef:96:44:67:9b:0d:c3:ba:b7:58:fc:5e:f8:dc:
    d0:94:c0:18:87:d9:02:b2:7a:94:b3:db:a6:ea:53:
    2d:38:bd:3f:ac:52:8b:5d:3b:53:da:f4:96:f6:d2:
    0d:26:93:7a:ce:6f:57:54:01:4f:2c:0f:d4:1b:09:
    c1:75:c1:7f:a1:91:57:b8:9f:92:7c:08:27:9d:b9:
    e0:6b:93:2d:6d:92:99:4c:97:89:52:3f:4d:5e:ee:
    00:88:8e:07:b1:d5:bc:1c:d5:a7:40:13:3c:d5:65:
    13:25:eb:c3:be:6b:fe:7d:1a:11:c2:15:64:b5:30:
    f2:c2:d1:4f:c2:55:f5:9c:30:bd:cf:10:70:cc:27:
    38:77:3c:6e:9a:bb:c8:18:32:d5:26:4a:e8:c4:fc:
    a3:a2:b5:ef:85:a3:93:1d:be:91:54:f0:d1:bf:17:
    4d:3a:d0:ef:36:06:55:01:b7:10:b3:6e:f7:09:6b:
    7f:48:57:01:d4:f0:2d:9c:dc:2e:56:60:05:ef:59:
    6f:d4:be:7a:6f:12:a7:2f:82:52:b1:22:18:9e:2b:
    69:50:00:ac:e0:ce:e0:3e:27:55:42:92:16:16:89:
    28:ec:28:30:09:d8:bf:e7:04:ca:4c:f9:57:a8:05:
    ee:f5:d7:74:36:ab:e5:c0:76:82:ab:52:84:24:47:
    24:56:79:86:19:ea:0d:dd:70:b5:7d:17:6e:07:6f:
    c3:ca:d3:f9:1d:cb:88:94:d1:7f:93:87:a3:a8:08:
    ac:67:b4:9c:33:e0:f9:3a:2f:01:44:d6:0b:2a:d9:
    8a:e7:5f:ee:b8:36:88:71:a6:bf:ff:82:08:7f:77:
    dd:63:9a:09:e4:42:dc:e1:57:11:a1:72:f7:14:24:
    ff:38:34:9e:de:0d:99:7a:b4:25:c8:ec:86:8d:0c:
    c8:b7:ab:bd:07:c5:f2:bb:06:c5:38:5d:e9:e8:f4:
    86:c2:44:a0:89:07:55:b3:d7:ea:27:51:d0:cd:6e:
    da:60:b2:d5:84:60:c8:92:4c:42:10:1e:35:f9:91:
    28:2f:f8:5e:2f:10:c2:87:ad:e0:9f:23:77:c2:54:
    05:6c:f6:e6:b5:c1:48:14:b9:51:c2:e1:88:8b:02:
    79:72:1b:3a:69:4a:0c:68:90:f7:b4:29:8a:5f:76:
    bb:7a:e0:66:b9:3d:ec:91:be:15:db:76:4e:56:b4:
    3c:f2:d8:23:f7:35:cf:4a:cf:45:55:94:fa:8e:79:
    45:51
```

- The modulus `n`:

```console 
modulus:
    00:d5:d1:bd:9a:bb:c5:c6:08:15:0e:9a:23:8e:70:
    4b:f6:87:a6:0f:a0:f5:b4:6c:46:58:f1:dd:86:80:
    64:a4:95:33:0b:55:a4:f4:f7:d3:87:41:94:b2:d1:
    6f:2a:e9:b8:c1:47:3b:0a:53:49:d6:0a:59:8d:44:
    34:8e:52:3f:53:cc:26:5b:51:6d:18:55:cb:c3:7a:
    5a:60:c4:f4:9b:80:d7:b6:c2:f9:3a:6f:be:59:a4:
    61:9b:95:4e:65:1c:68:59:a3:f3:f2:8a:47:5a:91:
    c8:0a:de:13:99:8d:fd:f0:fc:87:74:f3:d4:27:e8:
    9a:c9:37:da:fd:d2:98:b6:6e:b5:24:c4:7d:1c:ee:
    d3:85:fa:50:24:d2:6c:8a:29:af:21:f1:00:06:15:
    99:e8:39:b8:7c:22:4e:cd:14:6a:43:10:67:1f:23:
    9d:07:bc:50:69:f7:fd:47:4d:0f:6e:5d:e6:ad:c9:
    2e:41:de:70:ee:4c:39:67:92:3a:4e:b3:bc:2e:dd:
    b8:e0:48:a5:5a:cc:15:fd:50:7e:c5:d1:d0:ad:a9:
    d2:7f:e6:01:ba:16:88:80:43:45:6c:c3:6a:e1:25:
    d5:55:92:bb:f3:56:fd:73:86:7b:1d:41:57:e3:1b:
    ea:a2:f2:75:c7:3b:a9:1f:20:c8:ec:86:df:82:77:
    29:1b:c2:77:88:fe:8e:c2:2e:86:0c:b6:9e:d6:c7:
    d6:74:74:9d:e9:f3:33:e4:17:e8:b2:3d:63:ed:93:
    c0:a2:ee:6f:16:27:96:a3:35:74:ca:c5:de:fd:0e:
    c2:7a:f0:0d:7a:06:b0:54:5f:55:f7:a6:9d:fd:f4:
    aa:8d:72:8c:59:4e:ff:bf:16:d5:86:91:70:8c:a9:
    17:ea:44:85:30:06:d8:b7:c4:91:86:36:f9:7a:e4:
    10:30:a1:b4:12:16:29:49:01:3f:8f:a1:30:fd:e5:
    27:e7:af:e0:32:7b:ae:2a:52:29:78:40:e3:af:1f:
    32:7f:8f:89:8c:68:c8:13:03:41:27:e7:9e:d9:32:
    34:a0:f3:d9:db:d4:bb:c8:25:81:27:8c:04:ea:10:
    ea:0d:f5:ad:7b:89:6c:f6:0e:8b:73:16:e0:27:71:
    62:64:9c:d4:f2:54:5f:28:bc:1b:f0:0b:5c:df:d3:
    93:69:c5:2a:bd:9b:de:e2:30:64:39:f8:6b:8d:a2:
    ff:63:7b:de:70:72:62:ec:c7:a2:3b:75:3f:2e:e4:
    d8:d0:d5:7b:9d:f4:36:70:c4:bc:91:ca:2b:48:5e:
    0e:72:6d:a6:3a:0d:fe:05:e0:26:47:c5:66:de:8d:
    66:d4:ae:69:68:28:af:75:76:e1:40:ca:67:7f:60:
    b1:d0:d5
```

- The secret number `p` identified as prime1:

```console
prime1:
    00:f4:e2:6c:60:56:91:96:bf:53:07:91:be:96:cc:
    39:01:d8:30:dd:71:05:4f:f3:68:03:15:a5:a4:42:
    7c:29:4a:1d:f6:d9:29:bc:c7:98:f0:a2:96:29:8a:
    3d:6e:b9:82:7c:24:a7:bc:fe:70:05:e3:0c:c8:d6:
    20:a5:e2:ba:41:e8:39:aa:3e:26:91:25:51:1d:48:
    93:7e:3d:1d:38:4b:7d:fe:85:cd:80:7f:88:47:d8:
    23:62:9a:db:29:df:23:c4:60:b2:88:ab:d8:03:2b:
    e5:87:8c:d1:cb:53:40:55:5b:7c:69:f2:1b:3e:41:
    59:d3:1e:1f:fd:74:31:a6:97:37:31:0f:9e:77:a3:
    53:03:b8:9e:c2:e7:a8:e0:1a:16:0a:b5:95:44:39:
    f0:64:fb:22:ac:25:51:c8:45:fd:3e:85:46:a3:97:
    75:ec:f9:6d:d6:6f:1e:b2:78:42:22:13:70:94:d5:
    0e:2e:b0:f5:b5:65:c2:38:28:20:6e:3d:17:0b:fd:
    34:9a:3d:a6:4f:7e:25:20:ae:65:08:28:81:62:f9:
    90:8a:a6:5c:2c:b4:9e:85:07:e2:d1:e0:d4:1c:f9:
    8d:26:77:65:57:34:f4:1c:7c:7c:81:da:de:72:19:
    b7:46:e3:fd:22:e0:2f:08:3a:3f:1c:c1:49:9e:ae:
    51:6f
```

- The secret number `q` identified as prime2:

```console
prime2:
    00:df:86:56:6e:d5:81:f5:6b:9e:54:27:c1:3c:e1:
    a7:96:bb:5c:57:20:75:1f:81:56:bc:5a:ec:5b:f0:
    a1:48:96:01:f8:08:c9:ce:fa:bd:3d:9d:15:38:68:
    df:18:f9:aa:a9:67:60:b1:dc:d7:4c:b2:b3:44:5e:
    3a:18:b9:d6:a9:5f:c0:00:41:e4:50:de:c3:df:2e:
    87:9f:05:f5:15:23:52:cc:a1:71:ae:70:52:a0:47:
    cd:9d:63:c0:98:aa:cb:93:4e:57:db:af:19:7f:a2:
    54:16:58:ac:94:d2:26:08:6b:25:91:91:00:64:06:
    b7:1f:9a:00:b2:8f:6b:8d:e5:74:80:ef:48:49:b3:
    c8:39:74:7e:fd:df:90:8b:fa:fd:dc:09:48:46:66:
    43:42:5a:9a:a0:2f:b7:a6:7a:3d:79:e2:c6:0a:95:
    af:d2:c4:a7:24:1d:85:ed:e4:d8:cb:76:ad:ea:c2:
    13:ff:ea:80:ab:99:d4:1c:36:71:49:a1:42:06:53:
    e5:69:ef:c8:dd:1d:1e:f4:a5:9f:7f:19:ef:9c:93:
    49:60:fe:91:46:80:4f:ee:61:b6:e4:2b:f1:aa:31:
    96:aa:fd:d3:f0:4e:ee:d4:a5:83:df:bc:b4:8b:cd:
    7d:77:b5:5d:3a:e8:bc:87:96:c9:79:e8:53:2b:79:
    17:fb
```

All these elements were found by analyzing the output of ca.key


## Task 2 : Generating a Certificate Request for Your Web Server

> For a company to get a public-key certificate from our CA they first need to generate a Certificate Signing Request (CSR), which basically includes the company's public key and identity information. This will be sent to the CA, who will verify the identity information in the request and generate a certificate

Now we were tasked to create the *CSR* for our server, with the instructions on the guide, we used a command similar to the one we used to [create the self-signed certificate for the CA](#generating-self-signed-certificate).
The only change is the option *-x509*, where with it, it generates a self-signed certificate and without it, it generates a request.

```bash
$ openssl req -newkey rsa:2048 -sha256 \
    -keyout server.key
    -out server.csr \
    -subj "/CN=www.bank32.com/O=Bank32 Inc./C=US" \
    -passout pass:dees
```

- However, many website have different URL's, so as to allow the certificate to have multiple names we will add a `-addext` flag, that implements the extension *Subject Alternative Name*(SAN), that allows us to specify several hostnames.

The final command should look like this:

```bash
$ openssl req -newkey rsa:2048 -sha256 \
    -keyout server.key -out server.csr \
    -subj "/CN=www.l12g06.com/O=L12G06 Inc./C=PT" \
    -passout pass:dees \
    -addext "subjectAltName = DNS:www.l12g06.com, \
                              DNS:www.l12g06A.com, \
                              DNS:www.l12g06B.com"
```

After running it, we get this message:

```console
Generating a RSA private key
.................................................................................................+++++
................+++++
writing new private key to 'server.key'
-----
```

And we noticed that in our directory there were once again 2 files created, this time being `server.csr` and `server.key`

## Task 3 : Generating a Certificate for your server

> The CSR file needs to have the CA's signature to form a certificate. Generally the CSR files are sent to a trusted CA for their signature.

In this lab, however, we will use our own trusted CA to generate certificates. The following command turns the *server.csr* into an **X509** certificate (*server.crt*), using the CA's *ca.crt* and *ca.key* we made in [Task 1](#task-1--becoming-a-certificate-authority-ca).

```bash
$ openssl ca -config newopenssl.cnf -policy policy_anything \
             -md sha256 -days 3650 \
             -in server.csr -out server.crt -batch \
             -cert ca.crt -keyfile ca.key
```

*Note* : we use the `policy_anything` policy defined in the config file; this is not the default policy, since the latter has more restriction, that requires some of the subject information in the request to match those in the CA's certificate. The policy used does not enforce any matching rule.

For security reasons, the default setting in *openssl.cnf* does not allow *openssl ca* command to copy the extension field from the request to the final certificate. To enable that we edit in our config file the line:

```shell
# Extension copying option: use with caution.
copy_extensions = copy
```

After signing the certificate, following the guide, we used this command to print out the decoded content of the certificate, and check whether the alternative names were included

```bash
$ openssl x509 -in server.crt -text -noout
```
In the output we got:

```console
    X509v3 Subject Alternative Name: 
        DNS:www.l12g06.com, DNS:www.l12g06A.com, DNS:www.l12g06B.com
```

Showing us that the alternative names were in fact included.

Meaning that with this we had sucessfully generated a certificate for our server.

## Task 4 : Deploying Certificate in an Apache-Based HTTPS Website

This tasks has the purpose of seeing how public-key certificates are used by websites to secure web browsing.

The Apache server is already installed in our container, therefore we just need to configure the server so it knows where to get the private key and certificates.

### Configuring the Apache Server

- Inside our directory we have the directory **image_www**, which inside it there's a file called *bank32_apache_ssl.conf*, the configuration for the Apache Server.

- We need to tweak the *.conf* file in order to suit our website, on a sidenote, we moved the *server.crt* and *server.key* into the **volumes** directory (mounted shared folder between host machine and container) provided in the labsetup for an easier access.

```apache
<VirtualHost *:443>
    DocumentRoot /var/www/bank32
    ServerName www.l12g06.com
    ServerAlias www.l12g06A.com
    ServerAlias www.l12g06B.com
    DirectoryIndex index.html
    SSLEngine On
    SSLCertificateFile /volumes/server.crt
    SSLCertificateKeyFile /volumes/server.key
</VirtualHost>

<VirtualHost *:80> 
    DocumentRoot /var/www/bank32
    ServerName www.l12g06.com
    DirectoryIndex index_red.html
</VirtualHost>

# Set the following global entry to suppress an annoying warning message
ServerName localhost
```

### Starting Up the Server

- The server is not automatically started in the container, because of the need to type the password to unlock the private key.

So following the guide we start the server with the command:

```bash
$ service apache2 start
```

After this input, our server should have gone live, so to check this, we opened *Firefox* and typed out our website url.




## Task 5 : Launching a Man-In-The-Middle Attack



## Task 6 : Launching a Man-In-The-Middle Attack with a Compromised CA

