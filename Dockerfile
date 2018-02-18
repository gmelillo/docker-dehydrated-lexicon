FROM python:3-alpine3.6
MAINTAINER Gabriel Melillo <gabriel@melillo.me>

RUN apk add --update curl openssl bash git && \
    git clone https://github.com/lukas2511/dehydrated /dehydrated && \
    mkdir /dehydrated/hooks /dehydrated/certs && \
    pip install dns-lexicon && \
    curl https://raw.githubusercontent.com/AnalogJ/lexicon/master/examples/dehydrated.default.sh > /dehydrated/hooks/dehydrated.default.sh && \
    chmod +x /dehydrated/hooks/dehydrated.default.sh && \
    apk del git && \
    rm -rf /var/cache/apk/*

ENV 'PROVIDER' 'digitalocean'
ENV 'LEXICON_DIGITALOCEAN_TOKEN' ''
ENV 'LEXICON_GODADDY_KEY' ''
ENV 'LEXICON_GODADDY_SECRET' ''

WORKDIR /dehydrated

VOLUME /dehydrated/certs
VOLUME /dehydrated/accounts
VOLUME /dehydrated/chains
VOLUME /dehydrated/domains.txt

ENTRYPOINT ./dehydrated --register --accept-terms && ./dehydrated -c -t dns-01 -k './hooks/dehydrated.default.sh'
