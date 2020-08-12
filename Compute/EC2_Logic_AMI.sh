#!/bin/bash
#
# Build script for Covid19 project logic layer Amazon Machine Image.

# Install updates and Python libraries
sudo yum update -y 
sudo pip install boto3

# Configure AWS CodeDeploy
sudo yum install ruby wget -y
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
