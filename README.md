# docker-spark

Dockerfile for **Apache Spark** 
The image is available and ready to pull directly from [docker hub](https://hub.docker.com/r/canhtran/docker-spark/)

Libraries that contain in the image:

- Apache spark 2.3.1
- Python 3.6
- Scala 2.11.8
- Numpy 1.15.1
- scikit-learn 0.19.2
- Scipy 1.1.0

## Pull the image from Docker Repository
```bash
docker pull canhtran/docker-spark
```

## Build the image

```bash
docker build --rm -t canhtran/docker-spark
```

## Running the image

```bash
docker run -it -p 4040:4040 -p 8080:8080 -p 8081:8081 -h spark --name=spark canhtran/docker-spark
```

or

```bash
docker run -it -rm canhtran/docker-spark bash
```

## Check the image

#### PySpark

```bash
root@2d0472b61835:/app# pyspark
Python 3.7.0 (default, Sep  5 2018, 03:25:31)
[GCC 6.3.0 20170516] on linux
Type "help", "copyright", "credits" or "license" for more information.
18/09/17 16:35:35 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 2.3.1
      /_/

Using Python version 3.7.0 (default, Sep  5 2018 03:25:31)
SparkSession available as 'spark'.
```

#### Spark-shell
```bash
root@2d0472b61835:/app# spark-shell
18/09/17 16:36:15 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Spark context Web UI available at http://2d0472b61835:4040
Spark context available as 'sc' (master = local[*], app id = local-1537202182725).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 2.3.1
      /_/

Using Scala version 2.11.8 (Java HotSpot(TM) 64-Bit Server VM, Java 1.8.0_181)
Type in expressions to have them evaluated.
Type :help for more information.

scala>
```

## LICENSE
This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/canhtran/docker-spark/blob/master/LICENSE) file for details