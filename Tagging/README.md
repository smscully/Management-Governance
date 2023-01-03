All AWS cloud resources should have the following tags.

| Tag | Description | Key | Value Example |
|:-----------------|:------------|:--------|:--------|
| Budget | Budget allocated for this resource. | Budget | 100.00 |
| Cost Center | Accounting cost center associated with resource. | CostCenter | 901015 |
| Creator | Email of the creator of the resource. | Creator | name@emailaddress.com |
| Disaster Recovery | Business criticality of the resource. | DisasterRecovery | Non-critical\/Sensitive\/Vital |
| End Date | Date when project will end or resource is expected to retire. | EndDate | 20221231 |
| Environment | Subscription type or environment for the resource. | Env | Dev\/Test\/Prod |
| Owner | Email of the business owner of the resource. | Owner | name@emailaddress.com |
| Project | Project associated with resource. | Project | Covid19 |
| SLA Class | Service Level Agreement for this resource. | SLA | Basic\/Bronze\/Silver\/Gold\/Platinum |
| Start Date | Date when project began or resource was implemented. | StartDate | 20200315 |

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
