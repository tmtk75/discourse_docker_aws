# README

Providing a way to launch a fresh discourse via docker, which discourse team officially recommends.

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

Exeucte once to initialize.
```
$ make init
$ make bootstrap    # takes much time like about more than 10 minutes
```

To start the container, execute every time after launching VM.
```
$ make start
```


`make ssh` if you'd like to login.


## Installation on Vagrant

```
$ make init-vagrant
```
This runs `vagrant up` and generate `ssh-config` (NOTE: overwrite the existing one)

```
$ make init make bootstrap make start    # same above
$ make natpf
```
Don't forget `natpf` task, it configures NAP between your host OS and the VM.
And open <http://localhost:8080> with your browser.


