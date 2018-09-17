FROM python:3

LABEL maintainer "Calvin Tran <trandcanh@gmail.com>"

ENV APP_HOME /app

# Environment Setup
RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

COPY requirements.txt $APP_HOME

# Spark related variables.
ARG SPARK_VERSION=2.3.1
ARG SPARK_ARCHIVE_NAME=spark-${SPARK_VERSION}-bin-hadoop2.7
ARG SPARK_DOWNLOAD_URL=http://www-us.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE_NAME}.tgz

# Install java 8
RUN apt-get update && apt-get install -my gnupg && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    apt-get install -y --no-install-recommends libgomp1 libtk8.6 vim && \
    apt-get update && \ 
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y --no-install-recommends oracle-java8-installer && \
    # Install python package
    pip install --no-cache-dir scipy numpy scikit-learn && \
    pip install -I --no-cache-dir -r requirements.txt && \
    # Install Spark
    curl -L ${SPARK_DOWNLOAD_URL} | tar -xz -C /usr/local/ && \
    cd /usr/local && ln -s ${SPARK_ARCHIVE_NAME} spark && \
    # Remove deb packages
    apt-get purge -y --auto-remove git make g++ libssl-dev libffi-dev gnupg && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf requirements.txt && \
    rm -rf /var/cache/oracle-jdk8-installer 

ENV SPARK_HOME /usr/local/spark
ENV PATH $SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH

# Expose ports for monitoring.
# SparkContext web UI on 4040 -- only available for the duration of the application.
# Spark master’s web UI on 8080.
# Spark worker web UI on 8081.
EXPOSE 4040 8080 8081

CMD ["/bin/bash"]