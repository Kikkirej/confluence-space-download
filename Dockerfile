FROM alpine

COPY confluence-space-download.sh /opt/confluence-space-download.sh
RUN apk --no-cache add curl && chmod +x /opt/confluence-space-download.sh && mkdir /export

CMD /opt/confluence-space-download.sh