FROM ubuntu:20.04
COPY runAllIOTestsDocker_sync.sh /testFiles_sync/runAllIOTestsDocker_sync.sh
COPY runAllIOTestsDocker_async.sh /testFiles_async/runAllIOTestsDocker_async.sh
RUN apt-get update && \
    apt-get clean && \
    apt-get install -y sysbench
