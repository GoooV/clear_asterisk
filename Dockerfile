
FROM python:3.7.5-buster

# https://github.com/andrius/asterisk/tree/master/debian-buster-slim-16-current
ENV ASTERISK_VERSION 16-current
ENV OPUS_CODEC       asterisk-16.0/x86-64/codec_opus-16.0_current-x86_64
ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY build-asterisk.sh /
RUN /build-asterisk.sh

RUN mkdir -p /var/log/asterisk/cdr-csv

USER root

# WORKDIR /var/lib/asterisk/agi-bin/
# CMD ["/usr/sbin/asterisk", "-vvvvvvvvvvdddf", "-T", "-W", "-U", "asterisk", "-p"]
# CMD asterisk asterisk -fpTvvvvvvdddddddU root

COPY src /var/lib/asterisk/agi-bin
COPY conf/sip.conf /etc/asterisk/sip.conf
COPY conf/extensions.conf /etc/asterisk/extensions.conf
