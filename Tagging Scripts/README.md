# Tagging Scripts

## Tagging Overview

Tags are unique key-value pairs that can be assigned to AWS resources.  Each resource can have a maximum of 50 user-defined tags.  AWS best practices encourage employing tags to categorize resources based on department, environment, application, and other metadata.  This, in turn, helps organizations  monitor and control resource state, usage, cost, and access. 

AWS may also assign AWS generated tags, which usually begin with the prefix "aws:".  These AWS generated tags do not count against the 50 user-defined tag maximum, and AWS generated tags cannot be modified.

The AWS whitepaper *Tagging Best Practices* provides additional details regard the business justifications for resource tagging, as well as recommended tagging strategies.[^1]

## Use Cases

These scripts increases efficiency when adding tags through the AWS Console or Tag Editor.  They also simplify tagging for resource stacks created with CloudFormation templates.

### Increasing Efficiency When Using the AWS Console or Tag Editor

When resources are created through the AWS console, tags must be manually created.  Typing in key-value pairs is a time-consuming task that can also lead to typographical errors.  Scripts, on the other hand, contain a consistent, reusable set of tags, thereby improving productivity and reducing the likelihood of mistagging.

### Simplifying Tagging for CloudFormation Templates

Tags can be added programmatically to resource stacks at the time of creation using CloudFormation templates.  The reusability and versioning inherent to templates helps reduce tagging errors.  However, defining tags within CloudFormation templates can lead to additional rework when the tag keys or values must be updated, e.g. when the resources will have different owners, cost centers, etc.

Rather than updating the CloudFormation template code when tags change, a simpler method is to replace the inline template tag code with a reference to a tag script.  In this case, revisions to the CloudFormation template are reduced, with with the tag updates restricted to the tags.json file.

## Sample Tags

The file template_tagging_rgtapi.json includes the sample tags that the script will apply to affected resources.  These tags should be modified to meet the specific tagging requirements for each resource.  The sample tags listed below are based on the recommended mandatory tags that AWS suggests organization apply to all resources.

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

The scripts in this repository use the AWS Resource Groups Tagging API.  Follow the steps below to add tags to existing resources:

1. Download and save the tags.json file to either a local directory or an S3 bucket.
2. Open the tags.json file and add the Amazon Resource Names (ARNs) for the resources to which the tags will be added.  Please refer to the Amazon Resource Names (ARNs) section of the AWS General Reference for instructions on finding resource ARNs.[^3]
3. Customize the tag keys and values as appropriate. 
4. Using the AWS CLI, run the code listed below.  The CLI user account must have read permissions to the source bucket if the tags.json file is stored in S3.

```
aws resourcegroupstaggingapi tag-resources --cli-input-json file://tags.json
```

## References
[^1]:See https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html.
[^2]:See https://docs.aws.amazon.com/whitepapers/latest/establishing-your-cloud-foundation-on-aws/welcome.html.
[^3]:See https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html.
