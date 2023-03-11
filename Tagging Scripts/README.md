# Tagging Scripts

## Tagging Overview

Tags are unique key-value pairs that can be assigned to AWS resources.  Each resource can have a maximum of 50 user-defined tags.  AWS best practices encourage employing tags to categorize resources based on department, environment, application, and other metadata.  This, in turn, helps organizations  monitor and control resource state, usage, cost, and access. 

AWS may also assign AWS generated tags, which usually begin with the prefix "aws:".  These AWS generated tags do not count against the 50 user-defined tag maximum, and AWS generated tags cannot be modified.

The AWS Tagging Best Practices White Paper provides additional details regard the business justifications for resource tagging, as well as recommended tagging strategies.[^1]

## Use Cases

These scripts are intended for scenarios where tags are added to existing resources, to increase efficiency when using the AWS Console, and to suppliment CloudFormation stacks.

### Increasing Efficiency When Using the AWS Console

When resources are created through the AWS console, tags must be manually created.  Typing in key-value pairs is a time-consuming task that can also lead to typographic errors.  Scripts that contain a consistent set of tags that must be assigned to groups of resources therefore improve productivity and reduce the likelihood of mistagging.

### Supplimenting CloudFormation Stacks

???insert text???

## Sample Tags

The file ___.json includes the sample tags that the script will apply to affected resources.  These tags should be modified to meet the specific tagging requirements for each resource.  The sample tags listed below are based on the recommended mandatory tags that AWS suggests organization apply to all resources.

| Tag | Description | Key | Value Example |
|:-----------------|:------------|:--------|:--------|
| Owner | Owner and main user of resource. | Owner | name@emailaddress.com |
| Business Unit | Business Unit to which the resource belongs. | BusinessUnit | 100.00 |
| SDLC Stage | Indicates production vs. non-production status of the resource. | SDLCStage | Non-critical\/Sensitive\/Vital |
| Cost Center | Budget or account that will be used to pay for the resource. | CostCenter | 901015 |
| Financial Owner | Specifies who is responsible for the costs associated with the resource. | FinancialOwner | name@emailaddress.com |
| ComplainceFramework | Identifies resources that are associated with a compliance framework. | ComplianceFramework | 20221231 |
| Stack | Subscription type or environment for the resource. | Stack | Development |

Beyond mandatory tags, AWS also recommends several discretionary tags that can be used on an as-needed basis.  For more information regarding recommended organization tagging requirements, review the AWS White Paper Establishing Your Cloud Foundation on AWS.[^2]

## Adding Tags: General

While tags can be added using the Resources Tag Editor, for efficiency, the preferred method is to use the Resource Groups Tagging API with the project [Resource Group Tagging API JSON Template](https://raw.githubusercontent.com/RussetLeaf/RLCovid19/master/Tagging/template_tagging_rgtapi.json).  Sample AWS CLI code is listed below.

```
aws resourcegroupstaggingapi tag-resources --cli-input-json file://template_tagging_rgtapi.json
```

## Adding Tags: Exceptional Cases

The Resource Groups Tagging API does not support all AWS services, in which case the instructions listed below should be followed.

### IAM: Roles

Use the [IAM Roles Tagging JSON Template](https://raw.githubusercontent.com/RussetLeaf/RLCovid19/master/Tagging/template_tagging_iamroles.json).  Sample AWS CLI code is listed below

```
aws iam tag-role --cli-input-json file://template_tagging_iamroles.json
```

### SSM: Parameters

Use the [SSM Parameters Tagging JSON Template](https://raw.githubusercontent.com/RussetLeaf/RLCovid19/master/Tagging/template_tagging_parameters.json).  Sample AWS CLI code is listed below

```
aws ssm add-tags-to-resource --cli-input-json file://template_tagging_parameters.json
```

### EC2 (Includes Instances and VPC Resources)

Use the [EC2 Tagging JSON Template](https://raw.githubusercontent.com/RussetLeaf/RLCovid19/master/Tagging/template_tagging_ec2.json).  Sample AWS CLI code is listed below

```
aws ec2 create-tags --cli-input-json file://template_tagging_ec2.json
```

## References
[^1]See (https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html).
[^2]See (https://docs.aws.amazon.com/whitepapers/latest/establishing-your-cloud-foundation-on-aws/welcome.html).
