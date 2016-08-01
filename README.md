INFLUXDB
========

## Using the cool stuff

### Accessing the InfluxDB container



### Creating databases

    curl -POST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE mydb"

### Inserting data

Using single inserts

    curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'

Loading from a datafile

    curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary @cpu_data.txt

> Note: If your data file has more than 5,000 points, it may be necessary to split that file into several files in order to write your data in batches to InfluxDB. By default, the HTTP request times out after five seconds. InfluxDB will still attempt to write the points after that time out but there will be no confirmation that they were successfully written.

### Web Interfaces

- InfluxDB: http://localhost:8083/
- Chronograf: http://localhost:10000/

### IP on Docker

    ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'

## Going production

### General hardware guidelines for a single node

We define the load that you'll be placing on InfluxDB by the number of writes per second, the number of queries per second, and the number of unique [series](/influxdb/v0.13/concepts/glossary/#series). Based on your load, we make general CPU, RAM, and IOPS recommendations.

| Load         | Writes per second  | Queries per second | Unique series |
|--------------|----------------|----------------|---------------|
|  **Low**         |  < 5 thousand         |  < 5           |  < 100 thousand         |
|  **Moderate**    |  < 100 thousand        |  < 25          |  < 1 million        |
|  **High**        |  > 100 thousand        |  > 25          |  > 1 million        |
| **Probably infeasible**  |  > 500 thousand        |  > 100         |  > 10 million       |


#### Low load recommendations
* CPU: 2-4   
* RAM: 2-4 GB   
* IOPS: 500   

#### Moderate load recommendations
* CPU: 4-6  
* RAM: 8-32GB  
* IOPS: 500-1000  

#### High load recommendations
* CPU: 8+  
* RAM: 32+ GB  
* IOPS: 1000+  

Source: [InfluxDB docs](https://docs.influxdata.com/influxdb/v0.13/guides/hardware_sizing/#general-hardware-guidelines-for-a-single-node)

## Resources

- [InfluxDB Documentation](https://hub.docker.com/_/influxdb/)

