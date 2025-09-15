# Learning SQL Database

## Docker Setup

Let's say there are two container named **mysql-server** and **mysql-client**. As the name suggests **mysql-server** is the `mysql:8` database server container. **mysql-client** is a container that connects to mysql database server. 

- To connect from mysql-client container to mysql-server container i need to connect these containers on same network.
  Create network in docker and connect existing container like below
  ```sh
    docker network create mysql-network
    docker network connect mysql-network mysql-server
    docker network connect mysql-network mysql-client
  ```
- Add a new mysql user who is allowed to connected from **mysql-client** and grant privileges.
  ```sql
    -- FORMAT: CREATE USER <username>@<client docker container name i.e. host name >.<docker network on which server and client connected> IDENTIFIED BY <password>;
    CREATE USER 'client1'@'mysql-client.mysql-network' IDENTIFIED BY 'client1'; -- password is optional but recommended

    -- GRANT ALL PRIVILEGES grants privileges for all commands like INSERT UPDATE DELETE ALTER etc.
    -- *.* grant privileges on all databases and all tables in each database
    -- following grant is for demo purpose, in production environment cauciously grant permission to each users
    GRANT ALL PRIVILEGES ON *.* 'client'@'mysql-client.mysql-network' WITH GRANT OPTION;

    FLUSH PRIVILEGES;
  ```
  NOTE: `<username>@'%'` allow that user with **username** from any network and any host. This is major security vulnerability as a hacker with that username and password can access database from anywhere. MySQL adds a root user like this `'root'@'%'` by default. Drop this user but make sure there is root user on localhost like below
  ```sql
    USE mysql; -- the database mysql contains all users details
    SELECT user, host FROM User; -- to check all user 
    DROP USER 'root'@'%'; -- drop a paticular user
  ``` 

- But currently i can not connect to mysql server. Because mysql don't know what is **mysql-client.mysql-network**. Reason is MySQL does not resolves the host name by default. It needs the ip address. To solve this I have make some changes in **my.cnf**
  ```cnf
  [mysqld]
  skip-name-resolve=OFF # this is on by default and that's why mysql accepts ip only
  ```
  In `mysql` docker container this file is located in `/etc/my.cnf`.  Restart the mysql server to apply changes. To restart the docker container
  ```sh
    docker restart mysql-server
  ```
  Now connection from **mysql-client** on **mysql-network** with username **client1** and password **client1** will be accepted


