FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl
# Install tzdata so we dont get timezone prompt during install
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

COPY ./install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh

COPY ./verify.sh /tmp/verify.sh
RUN chmod +x /tmp/verify.sh

