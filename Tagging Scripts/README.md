# Tagging Scripts

The JSON tag files in this directory can be customized to add tags sets to single or multiple resources.  The instructions below explain how to use the files with the Resource Groups Tagging API, CloudFormation templates deployed via the AWS CLI, and CloudFormation templates run through AWS CodePipeline.

## Tagging Overview

Tags are unique key-value pairs that can be assigned to AWS resources.  Each resource can have a maximum of 50 user-defined tags.  AWS best practices encourage employing tags to categorize resources based on department, environment, application, and other metadata categories.  Tags help organizations  monitor and control resource state, usage, cost, and access. 

AWS may also assign AWS generated tags, which begin with the prefix "aws:".  These AWS generated tags cannot be modified and do not count against the 50 user-defined tag maximum.  The AWS whitepaper *Tagging Best Practices* provides additional details regard the business justification for resource tagging, as well as recommended tagging strategies.[^1]

## Sample Tags Included in the JSON Tag Files

The JSON tag files include the mandatory tags keys that AWS recommends organizations apply to all resources, along with example values.  The tag key-value pairs should be modified as necessary to meet organizational tagging requirements.

Beyond mandatory tags, AWS also suggests several discretionary tags that can be used on an as-needed basis.  For more information regarding AWS's recommended tagging strategies, review the AWS whitepaper *Establishing Your Cloud Foundation on AWS*.[^2]

The sample tags are listed below.

| Tag | Description | Key | Value |
|:-----------------|:------------|:--------|:--------|
| Owner | Owner and main user of resource. | Owner | Customer Loyalty Team |
| Business Unit | Business Unit to which the resource belongs. | BusinessUnit | Marketing |
| SDLC Stage | Indicates production vs. non-production status of the resource. | SDLCStage | Development |
| Cost Center | Budget or account that will be used to pay for the resource. | CostCenter | 12345 |
| Financial Owner | Specifies who is responsible for the costs associated with the resource. | FinancialOwner | Marketing |
| Compliance Framework | Identifies resources that are associated with a compliance framework. | ComplianceFramework | HIPPA |

## Usage Instructions

To add tags to existing resources, use the Resource Groups Tagging API.  To CloudFormation.

### Add Tags to Existing Resources Using the Resource Groups Tagging API

When resources are created through the AWS console, tags can be manually added by entering key-value pairs on the Add Tag screen.  To reduce repetition, the AWS Tag Editor supports adding tags to multiple existing resources at once.  However, the Tag Editor involves the manual process of entering key-value pair data for each tag.

The Resource Groups Tagging API increases efficiency and accuracy by using a JSON tag file that contains tag key-value pairs and Amazon Resource Names (ARNs) of existing resources.  Using the a JSON tag file eliminates the manual process of adding tags piecemeal, and also decreases the chance of tagging errors, as the JSON tag file can be reviewed and version-controlled.

1. Download and save the [api_tags.json](./api_tags.json) file to either a local directory or an S3 bucket.
2. Open the (./api_tags.json) file and add the Amazon Resource Names (ARNs) for the resources to which the tags will be added.  Please refer to the Amazon Resource Names (ARNs) section of the AWS General Reference for instructions on finding resource ARNs.[^3]
3. Customize the tag keys and values as appropriate. 
4. Using the AWS CLI, run the code listed below.  The CLI user account must have read permissions to the source bucket if the (cli_tags.json) file is stored in S3.

```
aws resourcegroupstaggingapi tag-resources --cli-input-json file://tags.json
```

### Simplifying Tagging for CloudFormation Templates

Tags can be added programmatically to resource stacks at the time of creation using CloudFormation templates.  The reusability and versioning inherent to CloudFormation templates helps reduce tagging errors.  Nevertheless, defining tags within CloudFormation templates can lead to duplicate work when the tag keys or values must be updated, e.g. when the resources will have different owners, cost centers, etc.  Moreover, for templates with multiple resources, the tags must be coded in the properties for every resource, reducing readability and increasing the likelihood of errors when copying and pasting tag sets.

Rather than updating the CloudFormation template code when tags change, a simpler method is to completely remove the inline template tag code and add tags using a JSON tag file.  The JSON file contains the tags key-value pairs and is applied at the time the CloudFormation template is run in the CLI.

1. Download and save the (/cfn_tags.json) file to either a local directory or an S3 bucket.
2. Open the (cfn_tags.json) file and customize the tag key-value pairs as needed. 
3. To run a test, download the (cfn_template.yaml) file.  Optionally, use a different working CloudFormation template.
4. Using the AWS CLI, run the code listed below.  The CLI user account must have read permissions to the source bucket if the files are stored in S3.

**NOTE:** Replace the BucketName ParameterValue with a unique name for an S3 bucket.

```
aws cloudformation create-stack --stack-name teststack --template-body file://cfn_template.yaml \
--parameters ParameterKey=BucketName,ParameterValue=test-bucketname-001 --tags file://cfn_tags.json
```

## References
[^1]:See [Tagging Best Practices](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html).
[^2]:See [Establishing Your Cloud Foundation on AWS](https://docs.aws.amazon.com/whitepapers/latest/establishing-your-cloud-foundation-on-aws/welcome.html).
[^3]:See [AWS General Reference](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
