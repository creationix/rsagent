
## Deploying an Agent

To deploy an agent, you only need install the binary on your machine and
register with some system to have it run automatically.  The agent also needs a
place to store local config/cache data on disk.

### As a simple user process.

```sh
$HOME/bin/rsagent $HOME/etc/rsagent.conf
```

The config file will contain.

```lua
endpoint = "wss://rsaep.rackspace.com"
token = "c1bb68c4-284a-48b2-87db-e4e5f9b1170d"
```

The agent itself will have the client certificates for Rackspace servers embedded in it, but you will be able to add new certs to the config file for testing.





An AEP is responsible for managing connections to the agents.
