### validate 
packer validate aws-server.json 


## build 
packer build -var="infra_env=staging" aws-server.json
