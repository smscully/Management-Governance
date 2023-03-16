# Tagging Scripts

The JSON tag files in this directory are customizable scripts that can be used to add tags sets to single or multiple existing resources.  The instructions below explain how to use the script with the CLI and CloudFormation templates (??).

## Tagging Overview

Tags are unique key-value pairs that can be assigned to AWS resources.  Each resource can have a maximum of 50 user-defined tags.  AWS best practices encourage employing tags to categorize resources based on department, environment, application, and other metadata.  This, in turn, helps organizations  monitor and control resource state, usage, cost, and access. 

AWS may also assign AWS generated tags, which usually begin with the prefix "aws:".  These AWS generated tags do not count against the 50 user-defined tag maximum, and AWS generated tags cannot be modified.

The AWS whitepaper *Tagging Best Practices* provides additional details regard the business justifications for resource tagging, as well as recommended tagging strategies.[^1]

## Use Cases

These scripts increases efficiency when adding tags to existing resources, and also simplify tagging for resource stacks created with CloudFormation templates.

### Increasing Efficiency Using the Resource Groups Tagging API

When resources are created through the AWS console, tags must be manually added to each resource at the time of creation.  Typing in key-value pairs is a time-consuming task that can lead to typographical errors.  While the AWS Tag Editor does alleviate some of the repetitive work associated with adding tags piecemeal, it nevertheless requires the AWS user to manually enter the key-value data for each tag.

The Resource Groups Tagging API increases efficiency and accuracy by using a JSON file to add tags to existing resources.  The JSON file contains the tag key-value pairs and the Amazon Resource Names (ARNs) of the resources to which the tags will be added, eliminating the repetition and propensity for error inherent to manaual tag addition.

### Simplifying Tagging for CloudFormation Templates

Tags can be added programmatically to resource stacks at the time of creation using CloudFormation templates.  The reusability and versioning inherent to templates helps reduce tagging errors.  However, defining tags within CloudFormation templates can lead to duplicate work when the tag keys or values must be updated, e.g. when the resources will have different owners, cost centers, etc.  Moreover, for templates with multiple resources, the tags must be coded in the properties for every resource, reducing readability, increasing the chance of error when copying and pasting tag sets.

Rather than updating the CloudFormation template code when tags change, a simpler method is to completely remove the inline template tag code and add tags using a JSON file.  The JSON file contains the tags key-value pairs and is applied at the time the CloudFormation template is run in the CLI.

## Sample Tags

The JSON tag files include sample tags that the script will apply to listed resources.  The tag files should be modified to meet the specific tagging requirements for the affected resources.  The sample tags listed below are based on the recommended mandatory tags that AWS suggests organization apply to all resources.

| Tag | Description | Key | Value Example |
|:-----------------|:------------|:--------|:--------|
| Owner | Owner and main user of resource. | Owner | Customer Loyalty Team |
| Business Unit | Business Unit to which the resource belongs. | BusinessUnit | Marketing |
| SDLC Stage | Indicates production vs. non-production status of the resource. | SDLCStage | Development |
| Cost Center | Budget or account that will be used to pay for the resource. | CostCenter | 12345 |
| Financial Owner | Specifies who is responsible for the costs associated with the resource. | FinancialOwner | Marketing |
| Compliance Framework | Identifies resources that are associated with a compliance framework. | ComplianceFramework | HIPPA |

Beyond mandatory tags, AWS also recommends several discretionary tags that can be used on an as-needed basis.  For more information regarding recommended organization tagging requirements, review the AWS whitepaper *Establishing Your Cloud Foundation on AWS*.[^2]

## Usage Instructions

To add tags to existing resources, use the Resource Groups Tagging API.  To CloudFormation.

### Resource Groups Tagging API

1. Download and save the (cli_tags.json) file to either a local directory or an S3 bucket.
2. Open the (cli_tags.json) file and add the Amazon Resource Names (ARNs) for the resources to which the tags will be added.  Please refer to the Amazon Resource Names (ARNs) section of the AWS General Reference for instructions on finding resource ARNs.[^3]
3. Customize the tag keys and values as appropriate. 
4. Using the AWS CLI, run the code listed below.  The CLI user account must have read permissions to the source bucket if the (cli_tags.json) file is stored in S3.

```
aws resourcegroupstaggingapi tag-resources --cli-input-json file://tags.json
```

### CloudFormation Templates

1. Download and save the (cfn_tags.json) file to either a local directory or an S3 bucket.
2. Open the (cfn_tags.json) file and customize the tag key-value pairs as needed. 
3. To run a test, download the (cfn_template.yaml) file.  Optionally, use a different working CloudFormation template.
4. Using the AWS CLI, run the code listed below.  The CLI user account must have read permissions to the source bucket if the files are stored in S3.

**NOTE:** Replace the BucketName ParameterValue with a unique name for an S3 bucket.

```
aws cloudformation create-stack --stack-name teststack --template-body file://cfn_template.yaml \
--parameters ParameterKey=BucketName,ParameterValue=test-bucketname-001 --tags file://cfn_tags.json
```

## References
[^1]:See https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html.
[^2]:See https://docs.aws.amazon.com/whitepapers/latest/establishing-your-cloud-foundation-on-aws/welcome.html.
[^3]:See https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html.
