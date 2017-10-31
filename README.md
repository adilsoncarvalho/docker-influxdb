# INFLUXDB

This is a very simple example of collecting timeseries data with InfluxDB and
other items from its stack and present them on Grafana.

## Why?

As a developer you'll contantly want to see what is going on _under the hood_
of your app (sort of) realtime or just have a good and reliable dashboard for
the operations folks to follow and you're not feeling into putting money on a
paid solution.

Despite the pros and cons of doing it yourself, I think that at least playing
with a solution that provides this solution is good.

## Used components

- [InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/)
- [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/)
- [Chronograf](https://www.influxdata.com/time-series-platform/chronograf/)
- [Grafana](https://grafana.com)

Why not [Prometeus](https://prometheus.io)? Well, I never tried and I should
try it!

## Resources

### Components of the TICK Stack

![](https://www.influxdata.com/wp-content/uploads/InfluxData_TICK-1.png)

- [Components of the TICK Stack](https://www.influxdata.com/time-series-platform/)
- [InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/)
- [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/)
- [Chronograf](https://www.influxdata.com/time-series-platform/chronograf/)
- [Kapacitor](https://www.influxdata.com/time-series-platform/kapacitor/)

### Documentation

- [InfluxDB](https://docs.influxdata.com/influxdb/v1.3/)
- [Telegraf](https://docs.influxdata.com/telegraf/v1.4/)
- [Chronograf](https://docs.influxdata.com/chronograf/v1.3/)
- [Kapacitor](https://docs.influxdata.com/kapacitor/v1.3/introduction/getting_started/)

## Using the cool stuff

All you need is Docker to run the containers:

    docker-compose up

You'll have the following service endpoints available:

- `http://localhost:8086`: InfluxDB database server
- `http://localhost:8888`: Choronograf app
- `http://localhost:3000`: Grafana app

### Initializing and using the InfluxDB container

#### Creating databases

    curl \
      -POST http://localhost:8086/query \
      --data-urlencode "q=CREATE DATABASE mydb"

#### Inserting data

Using single inserts

    curl \
      -i -XPOST 'http://localhost:8086/write?db=mydb' \
      --data-binary "cpu_load_short,host=server01,region=us-west value=0.64 $(date +%s)000000000"

Loading from a datafile

    curl \
      -i -XPOST 'http://localhost:8086/write?db=mydb' \
      --data-binary @cpu_data.txt

> Note: If your data file has more than 5,000 points, it may be necessary to split that file into several files in order to write your data in batches to InfluxDB. By default, the HTTP request times out after five seconds. InfluxDB will still attempt to write the points after that time out but there will be no confirmation that they were successfully written.

## Going to production

### Hardware selection

They have a compreensive guide for [hardware selection](https://docs.influxdata.com/influxdb/v1.3/guides/hardware_sizing/)
