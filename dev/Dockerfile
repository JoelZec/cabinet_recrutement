FROM alpine:latest

RUN apk update
RUN apk add --no-cache bash
RUN apk add --no-cache openjdk17
RUN apk add --no-cache maven
RUN mkdir /app
#ADD comrec /app#use bind mount when one wants to run a java app in the container