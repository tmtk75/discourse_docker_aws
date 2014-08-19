# README

## Prerequisites
- virtualenv to install ansible locally
- A tool to launch fresh hosts like awscli,  terraform or vagrant

```
$ make ansible    # Create .e and install ansible in it
$ . .env          # Enable the ansible
```


## Installation on an EC2 instance

TODO: Ensure ssh is available accessing to a host which you want to set up discourse w/ docker.

Fix `IdentityFile` and `HostName` in `ssh-config`.

```
$ make init
$ make bootstrap    # takes much time like about 10 minutes
$ make start
```

`make ssh` if you'd like to login.


## Installation on Vagrant

```
make init-vagrant
```

This runs `vagrant up` and generate `ssh-config` (NOTE: overwrite the existing one)

Follow the previous section.

