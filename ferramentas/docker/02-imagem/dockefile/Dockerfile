FROM ubuntu
RUN apt update && apt install curl --yes
WORKDIR /app
# COPY --chown=user:group --chmod=777 arquivo.txt .
COPY arquivo.txt .
ADD https://www.google.com/robots.txt google-robots.txt
LABEL contato="anderson.adolfo1998@gmail.com"
LABEL versao="1.0.0"
VOLUME /data
ARG VAR_TEXTO="Valor padrão"
RUN echo $VAR_TEXTO > arquivo.txt