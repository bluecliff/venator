# Ubuntu 14.04
FROM ubuntu:trusty
MAINTAINER bluecliff <lijsf@sina.com>


RUN apt-get update && \
    apt-get install -y python3 \
                       python3-dev \
                       python3-pip  \
    # 用完包管理器后安排打扫卫生可以显著的减少镜像大小
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 


# 配置默认放置 App 的目录
RUN mkdir -p /app
WORKDIR /app
ADD app.py /app/
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["docker-entrypoint.sh"]
CMD [""]
