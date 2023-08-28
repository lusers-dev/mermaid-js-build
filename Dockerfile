# multi-stage container build
FROM node:18.17.1 as builder

RUN git clone https://github.com/mermaid-js/mermaid-live-editor.git \
    && mv mermaid-live-editor mermaid \
    && cd mermaid \
    && yarn install \
    && yarn build 


FROM nginx:alpine as stage
RUN apk update \
    && apk upgrade 
COPY --from=builder --chown=nginx:nginx /mermaid/docs /usr/share/nginx/html


FROM nginx:alpine
COPY --from=stage / /

