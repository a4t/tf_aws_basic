FROM alpine:3.3
MAINTAINER Shigure Onishi <shigure.onishi@supership.jp>

ENV TERRAFORM_VERSION=0.7.13
RUN \
  apk update && \
  apk add unzip wget ca-certificates && \
  wget -P /tmp https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
  rm -rf /tmp/*

WORKDIR /sample
ENTRYPOINT ["/usr/bin/terraform"]
CMD ["--help"]
