FROM ubuntu

RUN mkdir -p /usr/src/sh
WORKDIR /usr/src/sh
COPY ./start.sh /usr/src/sh
RUN chmod a+x ./start.sh
ENTRYPOINT ["bash"]
CMD ["-c", "start.sh"]
EXPOSE 3000/tcp