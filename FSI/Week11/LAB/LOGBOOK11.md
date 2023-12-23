# Week 11 - Public-Key Infrastructure (PKI)

## DNS Setup

As mentioned in the guide we needed to set up an HTTPS web server with the name of our choice, to do this we added the following entries to `/etc/hosts`:

```console
# For PKI Lab
10.9.0.80        www.bank32.com
10.9.0.80        www.l12g06.com
```

## Task 1: Becoming a Certificate Authority (CA)

> A Certificate Authority (CA) is a trusted entity that issues digital certificates. These certifies the ownership of a public key by the named subject of the certificate.

Meaning that our goal in this task is to become a root CA, for then to use it to issue certificates for others (e.g. servers).
The root CA's certificates are self-signed, in contratry to those signed by another CA. Root CA's certificates are usually pre-loaded into most OS's, web browsers and other software that use PKI.

- `Root CA's certificates are unconditionally trusted.`

### Configuration

In order to use **OpenSSL** to create certificates, we need to have a configuration file. The default one is located in */usr/lib/ssl/openssl.cnf*. In order to make changes to the file, we copy it into our current directory, using the command:

```bash
$ cp /usr/lib/ssl/openssl.cnf new_openssl.cnf
```

Inside the copied file, there is a section titled : **Default CA setting**, that reads as follows

```conf
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

- We need to create several sub-directories and at the same time uncomment the *unique_subject* line to allow creation of certifications with the same subject.

First we create our main directory **demoCA**

```bash
$ mkdir demoCA
```

After that, we move into the **demoCA** directory and there we create a new directory called **newcerts**, that will be used to save our certificates.A

```bash
$ mkdir newcerts
```

Still inside the **demoCA** directory we create *index.txt*, an empty file, and a *serial* file with a single number in string format inside it.

`index.txt`

```bash
$ touch index.txt
```

`serial`

```bash
$ echo 1024 > serial
```

### Generating Self-Signed Certificate for our CA

> As previously mentioned, this will mean that this CA is totally trusted, and its certificate will serve as the root certificate.

To generate it we run the following command:

```bash
$ openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -keyout ca.key -out ca.crt
```

We were prompted to define a password, in our case *l12g06*, and then got the following message:

```bash
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:
```

To which we just filled with basic information. Giving us the final output of:

```bash
-----
Country Name (2 letter code) [AU]:PT
State or Province Name (full name) [Some-State]:Porto
Locality Name (eg, city) []:Paranhos
Organization Name (eg, company) [Internet Widgits Pty Ltd]:UP
Organizational Unit Name (eg, section) []:FSI23_24
Common Name (e.g. server FQDN or YOUR name) []:FSI
Email Address []:.
```

Upon the ending of the requirements for the CA, there were two files generated, those being `ca.key` and `ca.crt`

The first containing the CA's private key and the latter the public-key certificate.

### Decoding the Files Content

To look at the decoded content of the X509 certificate and the RSA key, we used the following commands:

```bash
$ openssl x509 -in ca.crt -text -noout
$ openssl rsa -in ca.key -text -noout
```


*Note*: `-text` means decoding the content into plain text; `-noout` means not printing out the encoded version

The output of both [*ca.crt*](/week11-extras/task1/ca_crt.txt) and [*ca.key*](/week11-extras/task1/ca_key.txt) can be found in the [task1 folder](/week11-extras/task1/)

Then the guide queried us with some questions:

#### What part of the certificate indicates this is a CA's certificate?

- In the output of *ca.crt* we got:

```conf
        X509v3 extensions:
            X509v3 Subject Key Identifier: 
                4F:C3:FC:DA:6E:08:72:BF:58:1B:52:A9:48:BA:2D:74:49:23:80:77
            X509v3 Authority Key Identifier: 
                keyid:4F:C3:FC:DA:6E:08:72:BF:58:1B:52:A9:48:BA:2D:74:49:23:80:77

            X509v3 Basic Constraints: critical
                CA:TRUE
            ...
```

The `CA:TRUE` indicating that this is a CA's certificate.

#### What part of the certificate indicates this is a self-signed certificate?

- By looking at the output provided in the [question before](#what-part-of-the-certificate-indicates-this-is-a-cas-certificate), we can see that the *Subject Key Identifier* and the *Authority Key Identifier* are equal, therefore this certificate is a self-signed one

#### In the RSA algorithm, we have a public exponent e, a private exponent d, a modulus n, and two secret numbers p and q, such that n = pq. Please identify the values for these elements in your certificate and key files.

- The public exponent `e`:

```conf
    publicExponent: 65537 (0x10001)
```

- The private exponent `d`:

```conf
    privateExponent:
    19:38:d9:fe:b0:94:d5:f6:dd:5a:51:b7:b2:ec:9d:
    7b:2e:82:e8:bc:b4:37:88:af:21:af:17:78:be:8b:
    5e:77:bf:f0:3d:17:7c:34:09:59:ff:03:1f:c1:41:
    ca:e1:6f:6d:22:e7:6a:34:72:bb:f4:36:46:f4:52:
    7b:14:33:0d:0b:2a:c5:e5:bb:a7:9c:c4:d4:bb:b3:
    f8:e6:32:b1:2b:4a:a7:00:36:47:83:c1:d2:32:ee:
    3c:2d:11:d0:f7:6d:65:ba:b7:75:cc:8e:45:80:80:
    92:1e:c1:94:d9:4f:05:d2:be:14:8b:c7:4f:1f:d4:
    1b:f3:62:07:be:09:4a:b8:7f:6f:76:78:01:a1:6b:
    18:31:73:21:48:cc:3e:cf:e8:bb:ca:5e:26:54:61:
    22:a6:5c:5a:34:dc:f0:3e:be:b0:c4:f0:73:5f:05:
    76:70:15:e4:ad:a8:99:1c:19:0c:d4:dc:e7:2f:18:
    79:19:77:7a:d6:89:aa:e8:f2:f3:2e:8a:aa:7a:f1:
    99:dc:24:95:ef:fe:dc:47:76:6b:e5:01:9f:e3:b0:
    f0:a4:cb:d6:49:ef:f0:75:1d:5b:5b:b8:ec:a7:d2:
    a0:98:5d:fe:e1:65:bc:fc:9d:26:9b:e8:48:6b:93:
    b7:ec:58:44:8b:0c:e8:48:d3:e3:67:fa:cc:92:35:
    18:3d:56:9f:b9:92:71:7c:58:e5:09:33:ac:ab:a2:
    ce:0d:d9:6b:26:39:53:86:0a:92:d5:50:ea:ea:f9:
    e4:fd:2e:5f:0c:29:88:11:58:15:52:10:5a:ce:90:
    91:74:ea:db:fa:70:f1:20:fb:0a:30:e2:18:84:94:
    53:f4:ed:d5:f4:21:25:27:b5:82:65:89:fe:93:a9:
    7d:13:61:f0:53:63:7c:df:b4:a6:11:66:69:d2:a4:
    ee:c8:8c:af:56:ab:0f:3d:7b:0e:14:a4:4a:3a:65:
    a6:db:18:b5:19:4c:51:86:1a:b2:08:88:15:69:19:
    46:0a:4d:df:1c:3c:24:db:17:dd:7c:35:98:fa:fe:
    bf:63:e0:f8:4a:99:b6:53:8d:e8:e7:fc:48:47:cb:
    91:38:f1:ce:1b:fe:bc:61:b8:c4:0c:4d:4a:09:a9:
    25:73:67:97:d5:8a:51:62:c0:89:0d:1d:8d:a5:4f:
    28:f5:2d:b9:04:51:7b:95:6f:2d:81:1c:7b:c1:a6:
    34:50:b5:81:14:22:20:7f:8e:2b:06:fb:d5:72:cd:
    94:d0:39:d4:87:0e:6b:e1:77:ca:92:0f:74:a4:a8:
    4f:45:e0:2e:f9:7c:0e:9c:e1:c4:7b:e6:46:b4:e2:
    00:ae:ba:57:99:f3:6b:e4:c6:c2:19:a1:76:80:33:
    ba:41
```

- The modulus `n`:

```conf
    modulus:
    00:b0:90:07:a4:d9:52:60:76:a8:25:99:c9:54:10:
    da:f8:49:e3:36:83:b7:b5:19:b8:dc:05:48:21:6a:
    5f:9f:d5:14:82:14:3a:39:85:19:ec:6e:64:b4:28:
    13:25:1c:e2:5f:c5:0f:65:e1:d6:56:7d:4c:98:c3:
    63:92:95:e8:14:83:af:be:d3:08:83:7b:fe:12:7f:
    e1:ef:fb:11:19:b4:16:28:38:5d:66:d1:0e:fb:cf:
    3a:a8:34:72:5b:25:6a:d6:ee:7a:30:90:7d:9f:62:
    a9:47:ad:d9:44:ee:c4:f7:76:4a:3f:99:82:2f:56:
    55:4f:1f:10:1c:00:af:3e:ab:04:6d:c2:2f:cd:11:
    93:36:6e:3c:1f:9b:bd:ec:c0:ee:53:c2:5d:19:9b:
    e7:79:03:6b:0a:ce:97:a0:f1:0a:6e:ae:45:e6:b8:
    1b:46:6d:63:2c:1f:35:2d:cb:3a:b4:f6:ce:11:f0:
    21:79:a0:87:4f:30:bd:eb:9e:28:41:3a:f3:65:0e:
    0e:ad:bd:90:99:b1:44:f8:76:33:d3:e7:a6:71:92:
    18:f2:8a:0c:71:b1:4e:fb:61:57:75:fe:79:f7:99:
    2a:2d:41:50:a5:5d:0b:0e:c6:94:83:b8:6f:af:2a:
    63:4d:47:0b:e4:4f:02:c5:5d:af:f1:02:f5:75:c5:
    f7:36:ba:69:dd:50:67:79:0b:b2:f5:02:c9:e1:3f:
    7d:d1:86:c1:9b:26:6e:fd:b7:5d:dd:17:94:22:1b:
    1c:e1:bc:76:4a:8e:3f:27:f1:ef:46:20:77:c5:59:
    55:e2:b7:a4:f8:69:2e:7d:e7:88:bc:76:e3:6a:ba:
    e6:42:e2:97:e9:9b:02:84:38:c2:67:b5:e9:1c:49:
    d4:e8:f7:7b:04:22:4d:5d:da:d2:56:e9:36:7b:d1:
    14:15:f8:41:f5:ec:49:d0:2c:65:b8:31:7d:00:ec:
    83:93:81:53:87:6e:50:5c:83:0d:ad:19:52:55:8d:
    85:a0:6b:c8:d8:20:6c:aa:6f:c1:19:3d:af:34:b9:
    b6:92:d7:0f:e3:c4:26:73:8b:0a:61:57:d9:2f:28:
    e0:86:a5:70:5b:41:a0:f2:62:23:71:4f:44:7a:47:
    7d:05:02:38:f8:62:1d:c2:e7:32:13:aa:05:19:2c:
    8c:71:df:06:15:8c:58:5f:c1:7e:5d:5b:d1:be:72:
    b3:03:fe:37:46:7a:6e:c2:4d:4b:af:8a:b9:d1:9a:
    67:f6:1d:73:bc:d0:2e:46:af:fd:d3:aa:f7:a2:69:
    6f:d7:1c:87:6b:a6:0d:d8:ff:90:20:07:0f:ba:d9:
    11:82:3b:96:ce:be:3c:e6:f5:3b:da:6a:e8:83:2a:
    b7:5e:6f
```

- Secret number `p` identified as prime1:

```conf
    prime1:
    00:e8:db:3c:2c:f4:a8:bd:d7:d1:6e:34:d0:d2:bb:
    48:f4:39:d5:e6:55:82:97:cc:27:cc:78:e0:8a:1a:
    e5:07:d4:4a:96:10:39:05:81:f8:03:5f:fd:05:4c:
    b1:47:b3:58:f2:c5:8e:74:5a:c8:bf:66:7e:3e:58:
    8b:75:88:4a:1f:61:6c:ea:92:1d:6e:71:a3:67:29:
    ba:6a:8b:a2:95:81:6b:1c:71:05:bf:c6:8a:b0:ed:
    1a:96:91:dd:39:3e:08:56:1e:ad:a8:f9:89:e9:c9:
    f9:cb:72:35:a2:c5:c8:0b:c3:2a:fa:51:f3:04:90:
    d9:18:42:d1:5e:54:8e:0c:c8:8b:2d:9b:ed:4a:88:
    a1:4f:ec:af:e2:5e:21:26:82:0d:17:41:6c:59:b1:
    87:5c:58:86:68:31:9a:45:74:c1:3f:2f:3c:c8:86:
    16:fd:65:fd:53:4d:f0:fa:f5:1c:07:51:e8:50:ec:
    44:06:16:93:79:e8:e2:c4:78:c3:f7:88:26:44:c7:
    85:de:68:86:26:38:2a:60:ab:d3:ad:c9:d5:88:83:
    3d:b0:c4:72:02:4e:df:17:3c:dd:d0:e2:6c:3d:f9:
    5e:84:27:e0:4f:cf:93:0c:34:8f:79:c1:68:c4:12:
    32:c2:23:c3:c7:2c:af:37:da:d1:bc:39:5f:fe:ab:
    5a:f1
```

- Secret number `q` identified as prime2:

```conf
    prime2:
    00:c2:1c:76:cd:be:f7:7e:a0:db:71:57:d0:d7:17:
    09:66:f5:1f:1d:4d:e1:4c:cb:61:9f:39:a8:2a:8d:
    80:0a:21:25:5c:bd:aa:6d:c3:42:21:f8:17:fc:38:
    e1:a8:eb:db:25:c5:dd:2f:94:3e:50:9c:1c:ec:34:
    aa:fa:2a:2d:82:fb:75:04:f1:11:0b:ae:44:80:a9:
    f5:60:63:ee:80:9b:28:86:72:38:e0:e8:01:80:e0:
    72:d6:3e:ba:98:d6:ca:10:83:6e:13:69:f4:b8:e5:
    dd:49:2b:87:01:eb:15:77:56:f9:41:57:d5:9f:94:
    2a:99:41:30:51:ac:73:e8:fe:8e:0f:8d:b2:0f:dd:
    1a:33:12:06:8e:6f:a5:36:50:50:97:4c:1e:5b:5b:
    28:81:d5:14:f3:55:a1:46:0c:fa:69:30:93:54:fc:
    50:47:bc:32:35:4f:0e:6f:38:8a:fa:4b:a4:b8:7e:
    43:b6:bc:7a:4e:16:74:fa:8a:3f:db:90:9c:a9:06:
    ba:95:e2:ef:f9:1f:71:52:8b:fd:a1:23:7d:72:72:
    44:37:20:5e:69:d1:fa:ee:ad:ed:6f:0e:31:30:a1:
    d7:6b:d1:00:45:7a:eb:be:14:7c:6f:7a:c4:2f:c6:
    8e:12:d3:11:69:0f:f2:d3:74:a4:b3:2e:3b:3e:94:
    8f:5f
```

All these elements were found by analyzing the output of *ca.key*

## Task 2: Generating a Certificate Request for Your Web Server

> For a company to get a public-key certificate from our CA they first need to generate a Certificate Signing Request (CSR), which basically includes the company's public key and identity information. This will be sent to the CA, who will verify the identity information in the request and generate a certificate

Now we were tasked to create the *CSR* for our server, with the instructions on the guide, we used a command similar to the one we used to [create the self-signed certificate for the CA](#generating-self-signed-certificate-for-our-ca).
The only change is the option *-x509*, where with it, it generates a self-signed certificate and without it, it generates a request.

At the same time since many websites can have different URLs we added an extension field that allows the certificate to have multiple names, i.e., allows us to specify several hostnames.

```bash
openssl req -newkey rsa:2048 -sha256 \
        -keyout server.key
        -out server.csr \
        -subj "/CN=www.l12g06.com/O=L12G06 Inc./C=PT" \
        -passout pass:dees \
        -addext "subjectAltName = DNS:www.l12g06.com, \
                                  DNS:www.l12g06-A.com, \
                                  DNS:www.l12g06-B.com"
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

## Task 3: Generating a Certificate for your Server


> The CSR file needs to have the CA's signature to form a certificate. Generally the CSR files are sent to a trusted CA for their signature.

In this lab, however, we will use our own trusted CA to generate certificates. The following command turns the *server.csr* into an **X509** certificate (*server.crt*), using the CA's *ca.crt* and *ca.key* we made in [Task 1](#task-1-becoming-a-certificate-authority-ca).

```bash
$ openssl ca -config new_openssl.cnf -policy policy_anything \
             -md sha256 -days 3650 \
             -in server.csr -out server.crt -batch \
             -cert ca.crt -keyfile ca.key
```

*Note* : we use the `policy_anything` policy defined in the config file; this is not the default policy, since the latter has more restriction, that requires some of the subject information in the request to match those in the CA's certificate. The policy used does not enforce any matching rule.

For security reasons, the default setting in *new_openssl.cnf* does not allow *openssl ca* command to copy the extension field from the request to the final certificate. To enable that we edit in our config file the line:

```shell
# Extension copying option: use with caution.
copy_extensions = copy
```

Now having changed that line in the configuration, we rerun the previous command generating in our directory the file *server.crt*.

- As per the guide instructions we used the following command to print out the decoded content of the certificate, and check whether the alternative names were included, which they were.

```bash
$ openssl x509 -in server.crt -text -noout
```

The output of both [*server.crt*](/week11-extras/task3/server_crt.txt) can be found in the [task3 folder](/week11-extras/task3/)

This meant that we had sucessfully generated a certificate for our server.

## Task 4 : Deploying Certificate in an Apache-Based HTTPS Website

This task has the purpose of seeing how public-key certificates are used by websites to secure web browsing.

The Apache server is already installed in our container, therefore we just need to configure the server so it knows where to get the private key and certificates.

### Configuring the Apache Server

- Inside our directory we have the directory **image_www**, which inside it there's a file called *bank32_apache_ssl.conf*, the configuration for the Apache Server.

- We need to tweak the *.conf* file in order to suit our website, on a sidenote, we moved the *server.crt* and *server.key* into the **volumes** directory (mounted shared folder between host machine and container) provided in the labsetup for an easier access.

```apache
<VirtualHost *:443>
    DocumentRoot /var/www/bank32
    ServerName www.l12g06.com
    ServerAlias www.l12g06-A.com
    ServerAlias www.l12g06-B.com
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

After this input, our server should have gone live, so to check this, we opened *Firefox* and typed out our website url (**https:\\www.l12g06.com**).
 
We were met with this warning:

![Website](/week11-extras/task4/WebsiteEntry.png)

By pressing the **Advanced:::** button and then the **Accept the Risk and Continue** we got this:

![Website Entry](/week11-extras/task4/Website.png)

- However, the warning in the beggining should not have been shown, this is due to the fact that the *CA* (us) was not on *Firefox's* list of trusted authorities. And since we used **https** it caused the website to show us a warning.0a

- To fix the issue, we needed to make the connection safe, so we had to add our CA to the known certificate issuers. So with a help from the guide, we typed the following URL in the address bar:

```url
about:preferences#privacy
```

It took us to this page:

![Firefox Settings](/week11-extras/task4/FirefoxSettings.png)

Where there was the option to **View Certificates...**:

![Certificate Manager](/week11-extras/task4/CertificateManager.png)

Now we just needed to import our certificate, *ca.crt*, which then this messaged popped up:

![Certificate](/week11-extras/task4/Certificate.png)

In which we selected to trust the CA to identify websites and email users.

After submiting the CA we tried to access the website again and this time there were no warning messages!

## Task 5: Launching a Man-In-The-Middle Attack

> A **Man-In-The-Middle** (MITM) attack is a cyberattack where the attacker secretly relays and possibly alters the communication between two parties who believe that they are directly communicating with each other, as the attacker has inserted themselves between the two parties.

For exaple, Alice wants to visit *example.com* via the HTTPS protocol. She need to get the public key from the *example.com* server. Alice will generate a secret, and encrypt the secret using the server's public key, and send it to the server. If an attacker can intercept the communication between Alice and the server, the attacker can replace the server's public key with its own public key. Therefore, Alice's secret is actually encrypted with the attacker's public key, so the attacker will be able to read the secret.

![MITM Attack](/week11-extras/task5/MITM.png)

### Setting up the malicious Website

Since in the real world we wouldn't be able to get a valid certificate for *www.example.com*, we decided to use an already existing social media website, that being [**Twitter**](https://twitter.com/), to try and become the Man in the Middle.

Since in [Task 4](#task-4--deploying-certificate-in-an-apache-based-https-website) we already had developed a configuration file for an apache server, we just changed the ServerName to the url that we intend to impersonate:

```apache
<VirtualHost *:443>
    DocumentRoot /var/www/bank32
    ServerName www.twitter.com
    ServerAlias www.l12g06-A.com
    ServerAlias www.l12g06-B.com
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

### Becoming the Man in the Middle

There are several ways to get the user's HTTPS request to land in our web server:

- Attack the *routing*, so the user's HTTPS request is routed to our web server. 
- Attack *DNS*, so when the victim's machine tries to find out the IP address of the target web server, it get the IP address of our web server.

We went with the option simulated in the guide, the *DNS* attack. Instead of launching an actual DNS cache poisoning attack, since we were also the victim, we simply modified the victim's machine's `/etc/hosts` file to emulate the result of a DNS cache poisining attack by mapping the real website to our malicious web server

```console
# For PKI Lab
...
10.9.0.80        www.twitter.com    # instead of www.l12g06.com
```

Now all that was needed to do was restarting the Apache server and check the results.

```bash
$ service apache2 restart
```

We then tried to access *www.twitter.com* and were met with the following screen:

![Twitter](/week11-extras/task5/FakeTwitter.png)

Meaning we had sucessfully got in the Middle of the victim and their desired website!

## Task 6: Launching a Man-In-The-Middle Attack with a Compromised CA

Lets assume that the root CA created in [Task 1](#task-1-becoming-a-certificate-authority-ca) is compromised by an attacker, and its private key is stolen. Therefore, the attacker can generate any arbitrary certificate using this CA's private key.

This task will serve as an example to the consequences of the compromised CA.

Since in the previous tasks we already had generated the CA credentials and had a fake website running, we just decided to create a new certificate for it. However, just like in [Task 2](#task-2-generating-a-certificate-request-for-your-web-server) we first had to create a *CSR*.

We did that by running the same command as before, but now with the changed parameters to fit our new fake website

```bash
openssl req -newkey rsa:2048 -sha256 \
        -keyout twitter.key
        -out twitter.csr \
        -subj "/CN=www.twitter.com/O=TWITTER Inc./C=PT" \
        -passout pass:dees \
```

Once again the terminal showed:

```console
Generating a RSA private key
.....+++++
..+++++
writing new private key to 'twitter.key'
-----
```

- And now in our directory there were two new files, *twitter.key* and *twitter.csr*

After that, just like in [Task 3](#task-3-generating-a-certificate-for-your-server), we signed the CSR:

```bash
$ openssl ca -config new_openssl.cnf -policy policy_anything \
             -md sha256 -days 3650 \
             -in twitter.csr -out twitter.crt -batch \
             -cert ca.crt -keyfile ca.key
```

Resulting in:

```console
Using configuration from new_openssl.cnf
Enter pass phrase for ca.key:
Check that the request matches the signature
Signature ok
Certificate Details:
        Serial Number: 4134 (0x1026)
        Validity
            Not Before: Dec 22 06:00:29 2023 GMT
            Not After : Dec 19 06:00:29 2033 GMT
        Subject:
            countryName               = PT
            organizationName          = TWITTER Inc.
            commonName                = www.twitter.com
        X509v3 extensions:
            X509v3 Basic Constraints: 
                CA:FALSE
            Netscape Comment: 
                OpenSSL Generated Certificate
            X509v3 Subject Key Identifier: 
                BB:22:A4:82:72:96:27:CD:E0:CA:9C:7C:9F:16:B6:9C:01:26:A3:5F
            X509v3 Authority Key Identifier: 
                keyid:4F:C3:FC:DA:6E:08:72:BF:58:1B:52:A9:48:BA:2D:74:49:23:80:77

Certificate is to be certified until Dec 19 06:00:29 2033 GMT (3650 days)

Write out database with 1 new entries
Data Base Updated
```

So now, we had our *twitter.crt* generated. And following the steps from the tasks before we just needed to add both the *twitter.crt* and *twitter.key* into the **/volumes** directory and tweak, once again the Apache Server Configuration.

```apache
<VirtualHost *:443>
    DocumentRoot /var/www/bank32
    ServerName www.twitter.com
    ServerAlias www.l12g06-A.com
    ServerAlias www.l12g06-B.com
    DirectoryIndex index.html
    SSLEngine On
    SSLCertificateFile /volumes/twitter.crt
    SSLCertificateKeyFile /volumes/twitter.key
</VirtualHost>

<VirtualHost *:80> 
    DocumentRoot /var/www/bank32
    ServerName www.l12g06.com
    DirectoryIndex index_red.html
</VirtualHost>

# Set the following global entry to suppress an annoying warning message
ServerName localhost
```

The changes made to the Apache from [Task 5](#task-5-launching-a-man-in-the-middle-attack) were the *SSLCertificateFile*  and *SSLCertificateKeyFile*, so that these would point to the new server files, i.e., *twitter.crt* and *twitter.key*.

All that was left to do now was to restart the server so that the changes made would be applied.

This time when entering the *Twitter* website we were met by this:

![Ca Danger](/week11-extras/task6/ImpersonatedTwitter.png)

This time the browser did not warn the user (us), or show a red background, meaning that the Man-In-The-Middle Attack was correctly executed, being able to mask the fake website to look like the real one, showing us how dangerous it can be when an attacker obtains a CA's private key.