# JSON Tag Files

Tags are unique key-value pairs assigned to AWS resources.  There are two types of tags: user-defined and AWS generated.  User-defined tags are assigned by users and help organizations monitor and control resource state, usage, cost, and access.  AWS best practices encourage implementing user-defined tags to categorize resources based on department, environment, application, and other metadata categories.  Each resource can have a maximum of 50 user-defined tags.    

AWS creates and assigns AWS generated tags, which begin with the prefix "aws:".  These AWS generated tags cannot be modified and do not count against the 50 user-defined tag maximum.  The AWS whitepaper *Tagging Best Practices* provides guidelines to develop organizational resource tagging strategies.[^1]

User-defined tags can be added using several methods.  Because JSON tag files can be reviewed and version-controlled, the methods described herein reduce the potential for tagging errors.  Each of the methods is preferable to manually adding tags via the AWS Console or Tag Editor.  Further, using a JSON tag file is more efficient than defining tags within a CloudFormation template, since templates require that tag sets be coded for every resource.

The JSON tag files in this folder add tag sets to AWS resources using one of the following three methods:

+ Resource Groups Tagging API
+ CloudFormation templates deployed via the AWS CLI
+ CloudFormation templates run in AWS CodePipeline

## Description Of The JSON Tag Files

There are three JSON tag files included in this folder:

+ [api_tags.json](./api_tags.json): used with the Resource Groups Tagging API
+ [cfn_tags.json](./cfn_tags.json): used with CloudFormation templates deployed via the AWS CLI
+ [codepipeline_template_config.json](./codepipeline_template_config.json): used with CloudFormation templates run in AWS CodePipeline

AWS recommends that organizations apply both mandatory and discretionary tags to all resources.[^2]  Each of the JSON tag files contains the baseline mandatory tags, along with example values.  The tag key-value pairs should be modified as necessary to meet organizational tagging requirements, including adding any applicable discretionary tags.

The tags contained in the JSON tag files are as follows:

| Tag | Description | Key | Example Value |
|:-----------------|:------------|:--------|:--------|
| Owner | Owner and main user of the resource. | Owner | Customer Loyalty Team |
| Business Unit | Business Unit to which the resource belongs. | BusinessUnit | Marketing |
| SDLC Stage | Indicates production vs. non-production status of the resource. | SDLCStage | Development |
| Cost Center | Budget or account that will be used to pay for the resource. | CostCenter | 12345 |
| Financial Owner | Specifies who is responsible for the costs associated with the resource. | FinancialOwner | Marketing |
| Compliance Framework | Identifies resources that are associated with a compliance framework. | ComplianceFramework | HIPPA |

## Usage Instructions

Follow the instructions below to add tags using the Resource Groups Tagging API, CloudFormation templates deployed via the AWS CLI, or CloudFormation templates run through AWS CodePipeline.

### Resource Groups Tagging API

Use the Resource Groups Tagging API to add tags to existing resources.

1. Download and save the [api_tags.json](./api_tags.json) file to either a local folder or an S3 bucket.
2. Open the [api_tags.json](./api_tags.json) file and add the Amazon Resource Names (ARNs) for the resources to which the tags will be added.  Please refer to the *Amazon Resource Names (ARNs)* section of the *AWS General Reference* for instructions on finding resource ARNs.[^3]
3. Customize the tag keys and values as appropriate. 
4. Using the AWS CLI, run the code listed below.  The CLI user account must have read permissions to the source bucket if the [api_tags.json](./api_tags.json) file is stored in S3.

```
aws resourcegroupstaggingapi tag-resources --cli-input-json file://tags.json
```

### CloudFormation Templates Deployed Via The AWS CLI

Follow these instructions when adding tags to resources that will be created through a CloudFormation template deployed via the AWS CLI.

1. Download and save the [cfn_tags.json](./cfn_tags.json) file to either a local folder or an S3 bucket.
2. Open the [cfn_tags.json](./cfn_tags.json) file and customize the tag key-value pairs as needed. 
3. To run a test, download the [cfn_template.yaml](./cfn_template.yaml) file.  Optionally, use a different valid CloudFormation template.
4. Using the AWS CLI, run the command listed below.  The CLI user account must have read permissions to the source bucket if the files are stored in S3.

**NOTE:** In the CLI command below, replace the BucketName ParameterValue with a unique name for an S3 bucket.

```
aws cloudformation create-stack --stack-name teststack --template-body file://cfn_template.yaml \
--parameters ParameterKey=BucketName,ParameterValue=test-bucketname-001 --tags file://cfn_tags.json
```

### CloudFormation Templates Run In AWS CodePipeline

AWS CodePipeline can create a continuous delivery workflow for CloudFormation templates, helping automate the creation of stacks and resources.  Tags are added to each of the resources using the CodePipeline template configuration file.  The [codepipeline_template_config.json](./codepipeline_template_config.json) file contains the AWS mandatory tags, along with sample values.  For a walkthrough of using Cloudformation with CodePipeline, see the *Continuous delivery with CodePipeline* section of the *AWS CloudFormation User Guide*.[^4]  The *AWS CloudFormation artifacts* section of the *AWS CloudFormation User Guide* describes the template configuration file.[^5]

## References
[^1]:See [Tagging Best Practices](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html).
[^2]:See [Establishing Your Cloud Foundation on AWS, Choosing tags for your environment](https://docs.aws.amazon.com/whitepapers/latest/establishing-your-cloud-foundation-on-aws/welcome.html).
[^3]:See [AWS General Reference, Amazon Resource Names (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
[^4]:See [AWS CloudFormation User Guide, Continuous delivery with CodePipeline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/continuous-delivery-codepipeline.html).
[^5]:See [AWS CloudFormation User Guide, AWS CloudFormation artifacts](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/continuous-delivery-codepipeline-cfn-artifacts.html).
