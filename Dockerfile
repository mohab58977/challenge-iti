# FROM redislabs/redis-py

# WORKDIR /app

# COPY requirements.txt requirements.txt

# # RUN pip install redis
# # RUN pip install tornado
# COPY . .

# EXPOSE 6379
# ENTRYPOINT ["bash","script.sh"]



# #  To define base image
# FROM python:3.7-alpine3.15

# #To define project dir
# WORKDIR /app

# #  To install requirements
# RUN pip install redis
# RUN pip install tornado

# #  To copy project files
# COPY . .

# #  To export EVN VAR
# ENV ENVIRONMENT=DEV
# ENV HOST=localhost
# ENV PORT=8000
# ENV REDIS_HOST=redis
# ENV REDIS_PORT=6379
# ENV REDIS_DB=0

# #  To run python app
# CMD [ "python3", "hello.py" ]

FROM python:3.8-alpine
WORKDIR /app
COPY . .

RUN apk --update add redis\
    && pip install -r requirements.txt

ENV ENVIRONMENT=DEV
ENV HOST=localhost
ENV PORT=8000
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV REDIS_DB=0

EXPOSE 6379
CMD ["/bin/sh","-c","redis-server --daemonize yes && python3 hello.py"]