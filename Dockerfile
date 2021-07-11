FROM python:3
RUN pip3 install django
RUN pip3 install mysqlclient
WORKDIR /web
COPY . .
WORKDIR ./django
CMD ["python3", "manage.py", "runserver", "0:8000"]
EXPOSE 8000
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENTRYPOINT ["dockerize", "-wait", "tcp://mysql_service:3306", "-timeout", "20s"]
