# Overview 
This Terraform script creates 3 AWS instances in the East region and installs the CockroachDB binary on each instance, which results in a 3 node cluster. This does not currently create some of the networking infrastructure needed for a more secure/robust environment such as VPCs, Security Groups, or a Load Balancer. 

For more a more in-depth look at a self-hosted AWS setup, visit this link 
<https://www.cockroachlabs.com/docs/v22.1/deploy-cockroachdb-on-aws>

## Instructions
1. Clone repo on local machine
2. Update the default values in variables.tf. 
- This assumes you have a Key Pair created in AWS
- Only varialbes required to update are private_key and key_name
3. `terraform init`
4. `terraform plan`
5. `terraform apply`
6. After completion, terraform will output the Public IP of each Node. 
- On your local machine ([with CockroachDB installed](https://www.cockroachlabs.com/docs/v22.1/install-cockroachdb-mac.html)) run the below command to initialize your cluster. Any Node IP will work
- `cockroach init --insecure --host=<ip address of any node>`

## Next Steps
1. Navigate to the CRDB Console
After initializing the cluster, you are able to access the Console on each node. An example is shown in the terraform output

2. Connect to the SQL Client
`cockroach sql --insecure --host=<address of any node>`
