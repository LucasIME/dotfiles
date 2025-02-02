FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl
# Install tzdata so we dont get timezone prompt during install
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt update && apt install -y gcc make build-essential

COPY . /tmp/expected/

COPY ./install.sh /tmp/install.sh
RUN chmod +x /tmp/install.sh

COPY .verify/verify.sh /tmp/verify.sh
RUN chmod +x /tmp/verify.sh

