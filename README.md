# README

TODO: Ensure ssh is available accessing to a host which you want to set up discourse w/ docker.

Fix `IdentityFile` and `HostName` in `ssh-config`.

```
$ make init
$ make bootstrap    # takes much time like about 10 minutes
$ make start
```

`make ssh` if you'd like to login.
