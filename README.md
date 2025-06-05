# AWS Advanced Networking Lab

This repo has two functions.
1. Act as a quick way to standup a lab environment for studying and experimenting with different AWS Networking resources.  
2. For use in a lesson about IaC as it concerns AWS Networking Resouces

## Prerequisites

1. Make sure you have git to clone this repo
1. awscli installed
2. awscli profile configured
3. terraform installed

### Installing the AWSCLI

AWS has a great documentation page on this so I will not re-invent the wheel: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html  

You can validate this setup is complete by running the following:  
```
aws --version
```

### Setting Up your AWS Profile.

Here you are linking your personal AWS account to the AWS CLI application.

1. Create a administrator user in the AWS console. You can use this guide for an emergency user for a list of detailed steps: https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started-emergency-iam-user.html  
2. Create Access keys for the new user. You can follow this document: https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html#cli-authentication-user-create  
3. Add a profile called `personal-admin` for the new user in the awscli config file. This can be done by running the following command:  
```powershell
aws configure --profile personal-admin
```
It will ask you a series of questions starting with Access Key and Secret Access Key that can be found in the csv file from number 2.  
```
PS C:\Users\andre> aws configure --profile personal-admin
AWS Access Key ID [None]: AKIATIXQII4ABCDEFGA
AWS Secret Access Key [None]: hi5KqUtl80WzRFX/saftWsdagfRFwefasdfaRfs
Default region name [None]: us-east-1
Default output format [None]: json
```
4. You can now set an environment variable that will tell AWSCLI to use this profile for all commands, this will also tell terraform and other applications using AWS SDKs to use this profile. This is how we get terraform to use the profile.  

Powershell(window):  
```
$Env:AWS_PROFILE="personal-admin"
```  
cmd(window, but you should use powershell):  
```
SET AWS_PROFILE=personal-admin
```  
bash/terminal(MacOS):  
```
export AWS_PROFILE="personal-admin"
```  
1. Now test the profile with the following command, this command asks an aws authentication API to tell you what role and account you are calling from:  
```
aws sts get-caller-identity
```  
The output should look something like this:  
```
PS C:\Users\andre\code\github.com\aredmond\aws-networking-lab> aws sts get-caller-identity
{
    "UserId": "AIDAJPIRX1234567890AB",
    "Account": "221111333344",
    "Arn": "arn:aws:iam::221111333344:user/aredmond"
}
```  

Now you are ready to run terraform and have it use that profile to deploy resource. **PLEASE NOTE** Which ever terminal you run the terraform command from needs to have that profile variable set `$Env:AWS_PROFILE="personal-admin"` or terraform will not work or use your default profile.  


### Installing terraform

There is a lot of different ways to install terraform if you have a method you like for installing software like `choco` please you that. Or you can follow the official guide here: https://developer.hashicorp.com/terraform/install 

That link just give your a binary for windows be sure to put that binary in your path. You can list your path as follows:  
```
$env:PATH
```
If you know how you can add the new terraform binary to your path, otherwise put it one of the existing folders in your path. **Note** If you use [choco](https://chocolatey.org/) all this will be handle for you. 

You can validate this by running the following: `terraform version` the output should look like this:  
```
PS C:\Users\andre\code\github.com\aredmond\aws-networking-lab> terraform version
Terraform v1.12.0
on windows_amd64

Your version of Terraform is out of date! The latest version
is 1.12.1. You can update by downloading from https://developer.hashicorp.com/terraform/install
```

## Building vpc-a

1. Navigate to the `stacks\vpc-a` folder in a terminal.  
```bash
cd stacks\vpc-a
```
2. Initialize, plan and apply terraform stack.  
```bash
terraform init
terraform apply
```

## Building bastion host

1. Navigate to the `stacks\bastion-a` folder in a terminal.  
```bash
cd stacks\vpc-a
```
2. Initialize, plan and apply terraform stack.  
```bash
terraform init
terraform apply
```

## Using CloudFormation

Please the following lab: [cfn\CloudFormation.md](cfn\CloudFormation.md)