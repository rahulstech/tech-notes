# Kafka Lesson

## Disclaimer
In this lesson i am using confluentic/cp-kafka and confluentic/cp-zookeeper. There are official docker images [apache/kafka](https://hub.docker.com/r/apache/kafka) and [zookeeper](https://hub.docker.com/_/zookeeper); but these requires extra configurations. 

## Docker Images Used:
1. **confluentic/cp-kafka:** kafka broker [link]()
2. **confluentic/cp-zookeeper:** zookeeper [link]()
3. **provectuslabs/kafka-ui:** manage kafka broker using gui in browser [link]()

## Terminology
- **Broker:** kafka server 
- **Cluster:** group of brokers
- **Prducer:** creates messages
- **Consumer:** receives messages
- **Consumer Group:** group of consumers
- **Topic:** collection of messages with same purpose. producer sends message in topic and consumer receives message from topic. it is and abstracton so that producers and consumers don't need to know each other and manage communications among them. 
- **Partition:** a logical sub collecton of topic. useful for horizontal scaling.
- **Offset:** index of a perticular message of a topic in a pertition. this is set by the broker.
- **Leader and Replica:** the orignal copy of a partition in a broker in a cluster is called **Leader** and the copy of the partition in another borker in the same cluster is called **Replica**. Leader for a partition is exactly one but there may be 0 or multiple Replicas of a partiion. Ideally all the available broker holdes exactly one leader and one or more replicas. thus parallel procession with maintaining backup handled. this makes kafka high availability and fault tolerance.
- **Zookeeper and KRaft:** both are metadata manager for kafka. Zookeeper is a third party service where are KRaft is kafka's own.
- **Kafka Connect:** to connect external source and sink. we can attact database, storage etc. to fetch and send data to and from kafka. threre are two terminologies related to connect
    - **Souce:** data fetched from
    - **Sink:** data sent to

## Consumer Group Restriction
Let's suppose **t1** has two partitions **p1** **p2**. There is a consumer group **g1** with three consumers **c1** **c2** **c3**. All the consumers of g1 are consuming to topic t1. Since three is only two partitions only c1 and c2 will be consuming from p1 and p2 partitions. c3 will remain idle untill one of c1 or c2 disconnectes. The restriction is, in each consumer group each consumer can consume from only one partition. two or more consumers can not consume from same partition of same topic from same consumer group. for example: **c1** **c3** can not consume from **p1** as both of them are in consumer group **g1**. However, two consumers from different consumer groups can consume from same pertition of same topic. for example. let say there is another consumer group **g2** with only consumer **c4**. then both **c1** and **c4** can consumer from partition **p1** of topic **t1** as they are from different consumer groups **g1** and **g2** respectively.

## Commands

In the following example it is assumed that kafka broker is running on `localhost:9092`.

- **Create Topic**
  - Create topic `tet-topic1` with 1 partition and replication factor 1. If there is only one broker then multiple pertitions may be created, but no replicas will be created. 
    ```sh
        kafka-topics.sh --create --bootstrap-server localhost:9092 --topic test-topic1 --partitions 1 --replication-factor 1
    ```
- **Show Topics:**
  ```sh
    kafka-topics.sh --bootstrap-server localhost:9092 --list
  ```
- **Get Details by Topic Name:**
   ```sh
    kafka-topics.sh --bootstrap-server localhost:902 --topic test-topic1 --describe
   ```
- **Create Console Producer:**
  - Create producer for single partition topic 
    ```sh
        kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test-topic1 
    ```
  - Create producer for multiple partition topic
    ```sh
        kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test-topic1 --property parse.key=true --property key.seperator=:
    ```
    Based on the provided message key the partition is selected by the broker. Message key and the actual message is seperated by : (colon) charater. I can choose anything as seperator. Here is an example:
    ```sh
    > key1:message1
    > key2:message2
    ``` 
- **Create Console Consumer:**
  - Create a console consumer with out any consumer group
    ```sh
        kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test-topic1
    ```
  - Create a console consumer and add to a consumer group named *g1*
    ```sh
        kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test-topic --group g1
    ```