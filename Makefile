opts=-var-file ~/.aws/development-sg.tfvars

plan:
	terraform plan $(opts)

apply:
	terraform apply $(opts)

destroy:
	terraform plan -destroy -out destroy.tfplan $(opts)
	terraform apply destroy.tfplan

bootstrap:
	ansible-playbook -i "`terraform output public_ip.community-jp`," bootstrap.yaml 

start:
	ansible-playbook -i "`terraform output public_ip.community-jp`," start.yaml

distclean:
	rm -f terraform.tfstate destroy.tfplan

