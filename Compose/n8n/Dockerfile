FROM docker.n8n.io/n8nio/n8n:latest
USER root
RUN npm install -g yjs fflate fzstd
RUN npm link yjs fflate fzstd
USER node
