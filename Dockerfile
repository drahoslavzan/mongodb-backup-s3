FROM mongo:4.2
LABEL maintainer="Drahoslav Zan <zandrahoslav@gmail.com>"

WORKDIR /app

RUN apt-get update && \
    apt-get install -y cron python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install awscli

COPY . .

CMD ["bash", "run.sh"]