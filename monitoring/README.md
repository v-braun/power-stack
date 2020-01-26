# Monitoring

## Setup

Go to the proxy folder  
``` sh
cd monitoring
```

Open (or create) a ```.env``` file and set all variables  
``` sh
INFLUXDB_NAME=name of the influx default db
INFLUXDB_USER_NAME=default admin user name
INFLUXDB_USER_PWD=admin user password

GRAFANA_USER_NAME=grafana default user name
GRAFANA_USER_PWD=grafana default user password
```

Run the stack with ```docker-compose```  
``` sh
docker-compose up -d
```