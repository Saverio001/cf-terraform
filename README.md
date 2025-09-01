
# CF training setup 

### Warning!

Cloudflare restrict the creation of partial domains to 
business customers; trying to set them up fails with
an error. 

https://community.cloudflare.com/t/terraform-partial-zone-signup-not-allowed/383187

This means that the last step (create a CF zone for the
second domain) will need to be done when the account
is upgraded.

Still, this terraform deployment creates in r53's domain2

- An A record internal.webserver_name -> the webserver address
- A CNAME in the form:  
    webserver_name -> internal.webserver_name.domain2.cdn.cloudflare.net

What needs to be done is to configure the partial zone on the CF console.


## 1. Log in to the CloudFlare console, and create an API token.

**NOTE:** While you are logged in the console, note down
your Cloudflare Account ID: it is the alphanumerical string you
see in the URL, when you are on your dashboard:

https://dash.cloudflare.com/**ACCOUNT-ID**/home/domains

You will need it later.

The first thing to to is to create an API token with the correct permisions.

    Zone > Zone > Edit (for writing/creating zones)
    Zone > DNS > Edit (for editing DNS records within zones)

1. From the main dashboard page, select your profile (top right icon).

2. Select "API tokens" from the menu on the right.

3. Click on "Create Token", and select "custom token" at the very end.

4. Select the two privileges above, give the token an expiration date and save

![](cloudflare-token.png)

5. Note down the token.

To make it usable, assign the token value to a shell variable.

If you are using bash, add this line to your .bashrc

    export CLOUDFLARE_API_TOKEN="<your secret token>"

You should be good to go.

## 2. (if you don't already have it) Create an AWS access key

Once you have done it, put it into your ~/.aws/credentials file:

    [default]
    aws_access_key_id =  <access key ID>
    aws_secret_access_key =  <secret access key>

## 3. Buy two cheap domains on R53. The cheaper, the better

## 4. In the AWS console, create a SSH key connect to your instance.

Make sure you note down the key name, you will need it later.

## 4. Create a file terraform.tfvars with these variables

    key_name              = "<your ssh key name>"
    domain1name           = "<your first domain>"
    domain2name           = "<your second domain>"
    webserver_name        = "<your webserver name>"
    cloudflare_account_id = "<your account ID>"

## 5. Run terraform plan, then terraform apply

## 6 Connect to the webserver

Terraform will display the url of the webserver; wait a bit, then try and connect (http only) 