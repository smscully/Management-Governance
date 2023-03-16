# Tagging Scripts

The JSON tag files in this directory add tag sets to AWS resources using one of three methods:

+ Resource Groups Tagging API
+ CloudFormation templates deployed via the AWS CLI
+ CloudFormation templates run in AWS CodePipeline

Each of these methods is preferable to manually adding tags via the AWS Console or Tag Editor.  Because JSON tag files can be reviewed and version-controlled, these methods described herein reduce the potential for tagging errors.

## Tagging Overview

Tags are unique key-value pairs assigned to AWS resources.  Each resource can have a maximum of 50 user-defined tags.  AWS best practices encourage using tags to categorize resources based on department, environment, application, and other metadata categories.  Tags help organizations monitor and control resource state, usage, cost, and access. 

AWS may also assign AWS generated tags, which begin with the prefix "aws:".  These AWS generated tags cannot be modified and do not count against the 50 user-defined tag maximum.  The AWS whitepaper *Tagging Best Practices* provides guidelines for organizational resource tagging strategies.[^1]

## Overview Of The JSON Tag Files

There are three JSON Tag Files included in the directory:

+ api_tags.json: used with the Resource Groups Tagging API
+ cfn_tags: used with CloudFormation templates deployed via the AWS CLI
+ codepipeline_template_config.json: used with CloudFormation templates run in AWS CodePipeline

AWS recommends that organizations apply both mandatory and discretionary tags to all resources.[^2]  Each of the JSON tag files contains the baseline mandatory tags, along with example values.  The tag key-value pairs should be modified as necessary to meet organizational tagging requirements, including adding any applicable discretionary tags.

The tags contained in the JSON Tag Files are as follows:

| Tag | Description | Key | Value |
|:-----------------|:------------|:--------|:--------|
| Owner | Owner and main user of resource. | Owner | Customer Loyalty Team |
| Business Unit | Business Unit to which the resource belongs. | BusinessUnit | Marketing |
| SDLC Stage | Indicates production vs. non-production status of the resource. | SDLCStage | Development |
| Cost Center | Budget or account that will be used to pay for the resource. | CostCenter | 12345 |
| Financial Owner | Specifies who is responsible for the costs associated with the resource. | FinancialOwner | Marketing |
| Compliance Framework | Identifies resources that are associated with a compliance framework. | ComplianceFramework | HIPPA |

## Usage Instructions

Follow the instructions below to add tags using the Resource Groups Tagging API, CloudFormation templates deployed via the AWS CLI, or CloudFormation templates run through AWS CodePipeline.

### Resource Groups Tagging API

The Resource Groups Tagging API adds tags to existing resources using the [api_tags.json](./api_tags.json) file.   eliminates the manual process of adding tags piecemeal, and also decreases the chance of tagging errors, as the JSON tag file can be reviewed and version-controlled.

1. Download and save the [api_tags.json](./api_tags.json) file to either a local directory or an S3 bucket.
2. Open the [api_tags.json](./api_tags.json) file and add the Amazon Resource Names (ARNs) for the resources to which the tags will be added.  Please refer to the *Amazon Resource Names (ARNs)* section of the *AWS General Reference* for instructions on finding resource ARNs.[^3]
3. Customize the tag keys and values as appropriate. 
4. Using the AWS CLI, run the code listed below.  The CLI user account must have read permissions to the source bucket if the [api_tags.json](./api_tags.json) file is stored in S3.

```
aws resourcegroupstaggingapi tag-resources --cli-input-json file://tags.json
```

### CloudFormation Templates Deployed Via The AWS CLI

Tags can be added programmatically to resource stacks at the time of creation using CloudFormation templates.  The reusability and versioning inherent to CloudFormation templates helps reduce tagging errors.  Nevertheless, defining tags within CloudFormation templates can lead to duplicate work when the tag keys or values must be updated, e.g. when the resources will have different owners, cost centers, etc.  Moreover, for templates with multiple resources, the tags must be coded in the properties for every resource, reducing readability and increasing the likelihood of errors when copying and pasting tag sets.

Rather than updating the CloudFormation template code when tags change, a simpler method is to completely remove the inline template tag code and add tags using a JSON tag file.  The JSON file contains the tags key-value pairs and is applied at the time the CloudFormation template is run in the CLI.

1. Download and save the [cfn_tags.json](./cfn_tags.json) file to either a local directory or an S3 bucket.
2. Open the [cfn_tags.json](./cfn_tags.json) file and customize the tag key-value pairs as needed. 
3. To run a test, download the [cfn_template.yaml](./cfn_template.yaml) file.  Optionally, use a different valid CloudFormation template.
4. Using the AWS CLI, run the command listed below.  The CLI user account must have read permissions to the source bucket if the files are stored in S3.

**NOTE:** In the CLI command below, replace the BucketName ParameterValue with a unique name for an S3 bucket.

```
aws cloudformation create-stack --stack-name teststack --template-body file://cfn_template.yaml \
--parameters ParameterKey=BucketName,ParameterValue=test-bucketname-001 --tags file://cfn_tags.json
```

### CloudFormation Templates Run In AWS CodePipeline

AWS CodePipeline can create a continuous delivery workflow for CloudFormation templates, helping automate the creation of stacks and resources.  Tags are added to each of the resources using the CodePipeline template configuration file.  The [codepipeline_template_config.json](./codepipeline_template_config.json) file contains sample tags.  For a walkthrough of using Cloudformation with CodePipeline, see the *Continuous delivery with CodePipeline* section of the *AWS CloudFormation User Guide*.[^4]  The *AWS CloudFormation artifacts* section of the *AWS CloudFormation User Guide* describes the usage and requirements of the template configuration file.[^5]

## References
[^1]:See [Tagging Best Practices](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html).
[^2]:See [Establishing Your Cloud Foundation on AWS, Choosing tags for your environment](https://docs.aws.amazon.com/whitepapers/latest/establishing-your-cloud-foundation-on-aws/welcome.html).
[^3]:See [AWS General Reference, Amazon Resource Names (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
[^4]:See [AWS CloudFormation User Guide, Continuous delivery with CodePipeline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/continuous-delivery-codepipeline.html).
[^5]:See [AWS CloudFormation User Guide, AWS CloudFormation artifacts](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/continuous-delivery-codepipeline-cfn-artifacts.html).
