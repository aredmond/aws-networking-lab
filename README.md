# AWS Advanced Networking Lab

This repo has two functions.
1. Act as a quick way to standup a lab environment for studying and experimenting with different AWS Networking resources.  
2. For use in a lesson about IaC as it concerns AWS Networking Resouces

## Prerequisites

1. awscli installed
2. awscli profile configured
3. terraform installed

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
