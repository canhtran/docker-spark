FROM python3

LABEL maintainer "Calvin Tran <trandcanh@gmail.com>"

ENV $APP_HOME /spark-app

# Environment Setup
RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

COPY requirements.txt $APP_HOME

RUN apt-get update && \
    apt-get install wget && \
    pip install -I --no-cache-dir -r requirements.txt && \
    rm requirements.txt && \
    rm -rf /var/lib/apt/lists/* && \

    apt-get install -y --no-install-recommends libgomp1 libtk8.6 && \

    # Install Java 8
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y --no-install-recommends oracle-java8-installer && \

    # Install Spark
    curl -s http://www-us.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz | tar -sz -C /usr/local && \
    cd /usr/local && ln -s spark-2.3.1-bin-hadoop2.7 spark && \

    # Cleaning deb packages
    apt-get purge -y --auto-remove git make g++ libssl-dev libffi-dev gnupg && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

ENV SPARK_HOME /usr/local/spark
