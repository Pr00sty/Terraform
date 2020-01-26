# Terraform first steps
Repository contains basic samples of Terraform usage with AWS Provider.


## Running

First to init Terraform type:
```bash
terraform init
```


If you want to make sure your configuration is syntactically valid and internally consistent, command below will check and report errors within modules, attribute names, and value types:
```bash
terraform validate
```


To print in terminal potentially changes in infrastructure type:
```bash
terraform plan
```


To apply changes in infrastructure type:
```bash
terraform apply
```


To destroy created resources type:
```bash
terraform destroy
```