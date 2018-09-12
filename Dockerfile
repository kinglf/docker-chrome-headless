FROM ubuntu:16.04

MAINTAINER kinglf

RUN apt-get update -qqy \
  && apt-get -qqy install libnss3 libxss1 libnss3-tools libfontconfig1 libappindicator1 libappindicator3-1 libindicator7 wget ca-certificates apt-transport-https inotify-tools language-pack-zh-hans fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Find the latest unstable version here: https://www.ubuntuupdates.org/google-chrome-unstable.
ENV CHROME_VERSION=70.0.3538.9-1
ENV LANG=zh_CN.UTF8
ENV LANGUAGE=zh_CN:zh:en_US:en
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - 
RUN echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN echo 
RUN apt-get update -qqy
RUN apt-get -qqy install google-chrome-unstable=${CHROME_VERSION}
RUN rm /etc/apt/sources.list.d/google-chrome.list
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*

EXPOSE 9222

ADD start.sh import_cert.sh /usr/bin/

RUN mkdir /data
VOLUME /data
ENV HOME=/data DEBUG_ADDRESS=0.0.0.0 DEBUG_PORT=9222

CMD ["/usr/bin/start.sh"]

