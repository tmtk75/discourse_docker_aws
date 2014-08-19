opts=-var-file ~/.aws/development-sg.tfvars

plan:
	terraform plan $(opts)

apply:
	terraform apply $(opts)

destroy:
	terraform plan -destroy -out destroy.tfplan $(opts)
	terraform apply destroy.tfplan

##
## Please edit below as you want
##
## Enable if using EC2 launched by terraform
#ansible-playbook=ansible-playbook -i "`terraform output public_ip.community-jp`,"
## Enable if using vagrant
ansible-playbook=ansible-playbook -i "default," -e vagrant=true


init-vagrant:
	vagrant up
	vagrant ssh-config > ssh-config

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

## virtualbox NAT
natpf:
	VBoxManage controlvm "discourse_docker" natpf1 ",tcp,127.0.0.1,8080,,80"

clean_natpf:
	VBoxManage controlvm "discourse_docker" natpf1 delete tcp_8080_80

## Ansible setup
ansible: .e/bin/ansible
.e/bin/ansible: .e
	.e/bin/pip2.7 install ansible
.e/bin/aws: .e
	.e/bin/pip2.7 install awscli
.e:
	virtualenv .e
