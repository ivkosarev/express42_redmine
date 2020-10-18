FROM ubuntu

COPY start.sh ./
ENTRYPOINT ["bash"]
CMD ["-c", "start.sh"]
EXPOSE 3000/tcp