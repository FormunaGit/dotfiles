FROM alpine:latest AS alpine

FROM n8nio/n8n:latest
USER root

COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /usr/lib/libapk.so* /usr/lib/
COPY --from=alpine /lib/ld-musl-* /lib/

RUN apk add --no-cache openjdk17-jre-headless

RUN npm install -g yjs fflate fzstd
RUN npm link yjs fflate fzstd
USER node
