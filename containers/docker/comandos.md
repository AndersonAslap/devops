# Docker — Cheat Sheet de Comandos

> Referência rápida de Docker CLI. Sintaxe mínima + finalidade.

## 1. Informações e configuração

```bash
docker version                         # Versões Client/Server
docker info                            # Informações do Docker
docker system info                     # Informações do sistema
docker context ls                      # Lista contexts
docker context show                    # Context atual
docker context use <context>           # Troca context
docker context create <name>           # Cria context
docker context inspect <context>       # Detalha context
docker context rm <context>            # Remove context
docker help                            # Ajuda geral
docker <command> --help                # Ajuda do comando
docker events                          # Eventos do daemon
docker events --filter type=container  # Filtra eventos
```

## 2. Imagens

```bash
docker images                          # Lista imagens
docker image ls                        # Lista imagens
docker pull <image>                    # Baixa imagem
docker push <image>                    # Envia imagem para registry
docker build -t <name>:<tag> .         # Cria imagem
docker build -f <Dockerfile> -t <name> . # Define Dockerfile
docker image inspect <image>           # Detalha imagem
docker image history <image>           # Histórico da imagem
docker image tag <src> <dst>            # Cria tag
docker image rm <image>                # Remove imagem
docker rmi <image>                     # Remove imagem
docker image prune                     # Remove imagens não usadas
docker image prune -a                  # Remove imagens não utilizadas
docker save -o image.tar <image>       # Exporta imagem
docker load -i image.tar               # Importa imagem
docker image export <image> ...        # Exportação de filesystem; normalmente use save
```

## 3. Containers

```bash
docker ps                              # Containers em execução
docker ps -a                           # Todos os containers
docker create <image>                  # Cria container parado
docker run <image>                     # Cria e inicia
docker run -d <image>                  # Executa em background
docker run -it <image> sh              # Terminal interativo
docker run --name <name> <image>       # Define nome
docker run --rm <image>                # Remove ao terminar
docker run -p 8080:80 <image>          # Publica porta
docker run -P <image>                  # Publica portas expostas
docker run -e KEY=value <image>        # Variável de ambiente
docker run --env-file .env <image>     # Arquivo de ambiente
docker run -v volume:/path <image>     # Monta volume
docker run --mount ... <image>         # Monta volume/bind/tmpfs
docker run --network <network> <image> # Define rede
docker run --restart unless-stopped <image> # Política de restart
docker run --hostname <name> <image>  # Define hostname
docker run --memory 512m <image>       # Limita memória
docker run --cpus 1 <image>            # Limita CPU
docker inspect <container>             # Detalha container
docker start <container>               # Inicia
docker stop <container>                # Para
docker restart <container>             # Reinicia
docker pause <container>               # Pausa processos
docker unpause <container>             # Retoma processos
docker kill <container>                # Finaliza imediatamente
docker rm <container>                  # Remove container
docker rm -f <container>               # Força remoção
docker rename <old> <new>              # Renomeia
docker wait <container>                # Aguarda término
```

## 4. Execução dentro do container

```bash
docker exec <container> <command>       # Executa comando
docker exec -it <container> sh         # Abre shell
docker exec -it <container> bash       # Abre Bash
docker exec -u root -it <container> sh # Executa como root
docker exec -e KEY=value <container> sh # Define variável
docker attach <container>               # Anexa ao processo
```

## 5. Logs

```bash
docker logs <container>                 # Exibe logs
docker logs -f <container>              # Logs em tempo real
docker logs --tail 100 <container>     # Últimas linhas
docker logs --since 10m <container>    # Logs recentes
docker logs -t <container>              # Inclui timestamp
docker logs --until 10m <container>    # Até determinado período
```

## 6. Cópia de arquivos

```bash
docker cp <container>:/path ./local     # Container → host
docker cp ./local <container>:/path     # Host → container
```

## 7. Portas e rede

```bash
docker port <container>                 # Portas publicadas
docker network ls                       # Lista redes
docker network create <network>         # Cria rede
docker network inspect <network>        # Detalha rede
docker network connect <network> <container> # Conecta container
docker network disconnect <network> <container> # Desconecta
docker network rm <network>             # Remove rede
docker network prune                     # Remove redes não usadas
```

### Drivers comuns

```text
bridge       # Rede padrão local
host         # Usa rede do host
none         # Sem rede
overlay      # Redes entre hosts/swarm
macvlan      # Container como dispositivo de rede
```

## 8. Volumes

```bash
docker volume ls                        # Lista volumes
docker volume create <volume>           # Cria volume
docker volume inspect <volume>          # Detalha volume
docker volume rm <volume>               # Remove volume
docker volume prune                     # Remove volumes não usados
docker run -v <volume>:/data <image>    # Monta volume
```

## 9. Bind Mount

```bash
docker run -v $(pwd):/app <image>       # Monta diretório
docker run --mount type=bind,src=$(pwd),dst=/app <image>
```

## 10. Dockerfile / Build

```bash
docker build .                          # Build
docker build -t app:1.0 .               # Define nome/tag
docker build --no-cache -t app .        # Ignora cache
docker build --pull -t app .            # Atualiza imagens base
docker build --target <stage> .         # Build de stage específico
docker build --build-arg KEY=value .    # Argumento de build
docker build --progress=plain .         # Logs detalhados
docker build --platform linux/amd64 .   # Define plataforma
docker buildx build ...                 # Build avançado/multiplataforma
```

## 11. Buildx

```bash
docker buildx ls                        # Lista builders
docker buildx inspect                   # Detalha builder
docker buildx create --name <name>      # Cria builder
docker buildx use <name>                # Seleciona builder
docker buildx build -t app .            # Build com BuildKit
docker buildx build --platform linux/amd64,linux/arm64 -t app --push .
docker buildx prune                     # Limpa cache
```

## 12. Docker Compose

```bash
docker compose version                  # Versão
docker compose config                   # Valida/renderiza configuração
docker compose up                       # Sobe serviços
docker compose up -d                    # Sobe em background
docker compose up --build               # Rebuild + sobe
docker compose down                     # Para e remove serviços
docker compose down -v                  # Remove também volumes
docker compose start                    # Inicia serviços existentes
docker compose stop                     # Para serviços
docker compose restart                  # Reinicia serviços
docker compose pause                    # Pausa serviços
docker compose unpause                  # Retoma serviços
docker compose ps                       # Lista serviços
docker compose logs                     # Logs
docker compose logs -f                  # Logs em tempo real
docker compose exec <service> sh        # Executa comando
docker compose run --rm <service> sh    # Cria execução temporária
docker compose build                    # Build dos serviços
docker compose pull                     # Baixa imagens
docker compose push                     # Envia imagens
docker compose pull <service>           # Baixa imagem do serviço
docker compose rm                       # Remove containers parados
docker compose images                   # Lista imagens usadas
docker compose top                      # Processos dos serviços
docker compose cp <service>:/path .     # Copia arquivos
docker compose watch                   # Observa alterações
```

## 13. Registry

```bash
docker login                             # Login no registry
docker logout                            # Logout
docker search <term>                     # Pesquisa Docker Hub
docker pull registry/image:tag           # Baixa imagem
docker tag app:latest user/app:latest    # Tag para registry
docker push user/app:latest              # Envia imagem
```

## 14. Docker Hub / Registry privado

```bash
docker login <registry>                  # Login
docker pull <registry>/app:tag           # Pull
docker tag app <registry>/app:tag        # Tag
docker push <registry>/app:tag           # Push
```

## 15. Inspect / Metadata

```bash
docker inspect <container>               # Metadados do container
docker inspect <image>                   # Metadados da imagem
docker container inspect <container>     # Inspeção explícita
docker image inspect <image>             # Inspeção explícita
docker volume inspect <volume>           # Metadados do volume
docker network inspect <network>         # Metadados da rede
```

## 16. Estatísticas e recursos

```bash
docker stats                             # CPU/memória em tempo real
docker stats <container>                 # Stats de um container
docker top <container>                   # Processos
docker system df                         # Uso de disco
docker system df -v                      # Uso detalhado
```

## 17. Limpeza

```bash
docker container prune                   # Remove containers parados
docker image prune                       # Remove imagens dangling
docker image prune -a                    # Remove imagens não usadas
docker volume prune                      # Remove volumes não usados
docker network prune                     # Remove redes não usadas
docker builder prune                     # Remove cache de build
docker builder prune -a                  # Remove todo cache não usado
docker system prune                      # Limpeza geral
docker system prune -a                   # Limpeza geral agressiva
docker system prune -a --volumes         # Inclui volumes
```

> Cuidado com `prune -a --volumes`: pode remover dados não utilizados que ainda sejam importantes.

## 18. Export / Import de containers

```bash
docker export <container> -o container.tar # Exporta filesystem
docker import container.tar image:tag      # Cria imagem do tar
```

> Para preservar histórico/camadas da imagem, prefira `docker save`/`docker load`.

## 19. Commit

```bash
docker commit <container> <image>:<tag>  # Cria imagem do container
docker commit -m "message" <container> <image>:<tag>
```

## 20. Tags

```bash
docker tag <image>:<tag> <repo>:<tag>    # Cria nova referência
docker image ls                          # Lista tags
docker image rm <repo>:<tag>             # Remove referência
```

## 21. Healthcheck

```bash
docker inspect <container>               # Consulta Health
docker run --health-cmd="curl localhost" <image> # Define healthcheck
docker run --health-interval=30s <image> # Intervalo
docker run --health-timeout=5s <image>   # Timeout
docker run --health-retries=3 <image>    # Tentativas
```

## 22. Segurança / usuário

```bash
docker run --user 1000:1000 <image>      # Define UID:GID
docker exec -u <user> <container> sh     # Executa como usuário
docker run --read-only <image>           # Filesystem somente leitura
docker run --cap-drop=ALL <image>        # Remove capabilities
docker run --security-opt ... <image>    # Opções de segurança
```

## 23. Processos / sinais

```bash
docker kill <container>                  # SIGKILL padrão
docker kill -s SIGTERM <container>       # Envia sinal
docker stop -t 10 <container>            # Graceful stop
docker pause <container>                 # Congela processos
docker unpause <container>               # Descongela
```

## 24. Labels

```bash
docker run --label app=api <image>       # Adiciona label
docker ps --filter label=app=api         # Filtra por label
docker inspect --format '{{json .Config.Labels}}' <container>
```

## 25. Filtros

```bash
docker ps --filter status=running        # Containers ativos
docker ps --filter status=exited         # Containers encerrados
docker ps --filter name=api              # Por nome
docker ps --filter label=app=api         # Por label
docker images --filter dangling=true     # Imagens dangling
docker images --filter reference='nginx*' # Por referência
```

## 26. Formatação

```bash
docker ps --format "{{.ID}} {{.Names}}"
docker images --format "{{.Repository}}:{{.Tag}}"
docker inspect -f '{{.State.Status}}' <container>
docker inspect -f '{{.NetworkSettings.IPAddress}}' <container>
```

## 27. DNS / Conectividade

```bash
docker exec <container> cat /etc/hosts  # Hosts
docker exec <container> cat /etc/resolv.conf # DNS
docker inspect <container>              # IP/rede
docker network inspect <network>        # Containers/rede
docker exec <container> ping <host>     # Teste ICMP
docker exec <container> curl <url>      # Teste HTTP
```

## 28. Docker Swarm

```bash
docker swarm init                        # Inicializa Swarm
docker swarm join --token <token> ...    # Adiciona node
docker swarm join-token worker           # Exibe token worker
docker swarm join-token manager          # Exibe token manager
docker swarm leave                       # Remove node do Swarm
docker swarm update ...                  # Atualiza Swarm
docker swarm ca                          # Exibe CA
docker swarm unlock                      # Desbloqueia
docker swarm unlock-key                  # Exibe chave
docker swarm unlock-key --rotate         # Rotaciona chave
```

## 29. Swarm Nodes

```bash
docker node ls                           # Lista nodes
docker node inspect <node>               # Detalha node
docker node ps <node>                    # Tasks do node
docker node promote <node>               # Promove para manager
docker node demote <node>                # Rebaixa manager
docker node update <node> ...            # Atualiza node
docker node rm <node>                    # Remove node
docker node rm --force <node>            # Força remoção
```

## 30. Swarm Services

```bash
docker service ls                        # Lista services
docker service create --name api image   # Cria service
docker service inspect <service>         # Detalha
docker service ps <service>              # Tasks
docker service logs <service>            # Logs
docker service scale api=3               # Escala
docker service update <service> ...      # Atualiza
docker service rollback <service>        # Rollback
docker service rm <service>              # Remove
```

## 31. Swarm Stack

```bash
docker stack ls                          # Lista stacks
docker stack deploy -c compose.yml app   # Deploy
docker stack services app                # Services da stack
docker stack ps app                      # Tasks
docker stack services app --filter ...   # Filtra services
docker stack rm app                      # Remove stack
```

## 32. Swarm Secrets

```bash
docker secret ls                         # Lista secrets
docker secret create <name> ./secret.txt # Cria
docker secret inspect <name>             # Detalha metadados
docker secret rm <name>                  # Remove
docker service create --secret <name> image
```

## 33. Swarm Configs

```bash
docker config ls                         # Lista configs
docker config create <name> ./config     # Cria
docker config inspect <name>             # Detalha
docker config rm <name>                  # Remove
```

## 34. Plugins

```bash
docker plugin ls                         # Lista plugins
docker plugin install <plugin>           # Instala
docker plugin inspect <plugin>           # Detalha
docker plugin enable <plugin>            # Habilita
docker plugin disable <plugin>           # Desabilita
docker plugin upgrade <plugin>           # Atualiza
docker plugin rm <plugin>                # Remove
```

## 35. Trust / Content Trust

```bash
docker trust inspect <image>             # Inspeciona assinatura
docker trust key generate <name>         # Gera chave
docker trust signer add <name> <image>   # Adiciona signer
docker trust signer remove <name> <image> # Remove signer
docker trust sign <image>                # Assina imagem
docker trust revoke <image>              # Revoga assinatura
```

## 36. Checkpoint

```bash
docker checkpoint create <container> <name> # Cria checkpoint
docker checkpoint ls <container>            # Lista checkpoints
docker checkpoint rm <container> <name>     # Remove checkpoint
```

## 37. Manifest / Multi-arch

```bash
docker manifest inspect <image>          # Inspeciona manifest
docker manifest create <image> ...       # Cria manifest
docker manifest annotate <image> ...     # Adiciona arquitetura
docker manifest push <image>             # Envia manifest
docker manifest rm <image>               # Remove manifest local
```

## 38. Scan

```bash
docker scout quickview <image>           # Visão de segurança
docker scout cves <image>                # CVEs
docker scout recommendations <image>     # Recomendações
docker scout compare <image> ...        # Compara imagens
docker scout version                     # Versão Scout
```

## 39. System

```bash
docker system df                         # Espaço usado
docker system events                     # Eventos
docker system info                       # Informações
docker system prune                      # Limpeza
```

## 40. Diagnose / Troubleshooting

```bash
docker ps -a                              # Ver status
docker logs <container>                  # Ver logs
docker inspect <container>               # Ver configuração
docker stats <container>                 # Ver recursos
docker top <container>                   # Ver processos
docker exec -it <container> sh           # Entrar no container
docker port <container>                  # Ver portas
docker network inspect <network>         # Ver rede
docker volume inspect <volume>           # Ver volume
docker events                            # Ver eventos
```

## 41. Comandos genéricos

```bash
docker <command> --help                  # Ajuda
docker <object> ls                       # Lista
docker <object> inspect <name>            # Detalha
docker <object> rm <name>                 # Remove
docker <object> prune                     # Limpa não utilizados
```

## 42. Objetos principais

| Comando | Objeto |
|---|---|
| `container` | Containers |
| `image` | Imagens |
| `network` | Redes |
| `volume` | Volumes |
| `builder` | Builders/cache |
| `compose` | Aplicações Compose |
| `system` | Sistema Docker |
| `context` | Contextos |
| `plugin` | Plugins |
| `secret` | Secrets do Swarm |
| `config` | Configs do Swarm |
| `node` | Nodes do Swarm |
| `service` | Services do Swarm |
| `stack` | Stacks do Swarm |
| `swarm` | Cluster Swarm |
| `manifest` | Image manifests |
| `trust` | Assinaturas |
| `scout` | Segurança/análise |

## 43. Sintaxe geral

```text
docker [comando] [subcomando] [opções] [argumentos]
```

Exemplo:

```bash
docker run -d --name api -p 8080:80 nginx:latest
```

`docker` = CLI  
`run` = ação  
`--name` = nome  
`-p` = publicação de porta  
`nginx:latest` = imagem
