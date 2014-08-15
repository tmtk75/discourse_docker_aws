opts=-var-file ~/.aws/development-sg.tfvars

plan:
	terraform plan $(opts)

apply:
	terraform apply $(opts)

destroy:
	terraform plan -destroy -out destroy.tfplan $(opts)
	terraform apply destroy.tfplan

ansible-playbook=ansible-playbook -i "`terraform output public_ip.community-jp`,"
#ansible-playbook=ansible-playbook -i "default,"

init:
	$(ansible-playbook) init.yaml 

bootstrap:
	$(ansible-playbook) bootstrap.yaml 

start:
	$(ansible-playbook) start.yaml

stop:
	$(ansible-playbook) stop.yaml

ssh:
	ssh -F ssh-config default

distclean:
	rm -f terraform.tfstate destroy.tfplan

