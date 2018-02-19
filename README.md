# dehydrated-lexicon

This docker container have inside the latest version of dehydrated and lexicon cli.
It is met to create and renew certificates using dns validation.

---

## Environment

All the environment configuration supported by `dehydrated` and `lexicon` are supported and used if provided.

**Minimumn requirement :**

- PROVIDER (the provider name in lowercase to be passed to lexicon)
- LEXICON_PROVIDER_* (ALL the variable used by lexicon to authenticate on provider)

## Example for digitalocean

With this docker-compose wou will be able to generate/renew all the domains contained into the `domains.txt` and retrive all the data from the folder `certs`

`docker-compose.yaml`
```yaml
version: '3'

services:
  dehydrated:
    container_name: letsencrypt
    image: gmelillo/dehydrated-lexicon:latest
    volumes:
      - ./certs:/dehydrated/certs
      - ./domains.txt:/dehydrated/domains.txt
      - ./accounts:/dehydrated/accounts
      - ./chains:/dehydrated/chains
    environment:
      LEXICON_DIGITALOCEAN_TOKEN: "DO_TOKEN_GENERATED_ON_THE_SITE"
      PROVIDER: "digitalocean"
```

`docker run`
```bash
docker run --it --rm --name letsencrypt \
  -v "$(pwd)/certs:/dehydrated/certs" \
  -v "$(pwd)/domains.txt:/dehydrated/domains.txt" \
  -v "$(pwd)/accounts:/dehydrated/accounts" \
  -v "$(pwd)/chains:/dehydrated/chains" \
  -e LEXICON_DIGITALOCEAN_TOKEN="DO_TOKEN_GENERATED_ON_THE_SITE" \
  -e PROVIDER="digitalocean" \
  gmelillo/dehydrated-lexicon:latest
```
