FROM alpine:3.20.1

RUN apk update \
  && apk add git go python3 rust openjdk11 nodejs npm \
  && apk add make cargo cargo-make \
  && apk add ansible \
  && apk add nginx \
  && apk add curl bind-tools tcpdump \
  && apk add doggo \
  && apk add openssh-client sshpass \
  && apk add openssl \
  && apk add ca-certificates \
  && apk add sudo \
  && apk add bash zsh \
  && apk add ncurses \
  && apk add gcompat \
  && apk add xdg-utils \
  && apk add tzdata \
  && apk add docker docker-cli-compose docker-cli-buildx docker-bash-completion \
  && apk add podman podman-bash-completion podman-zsh-completion podman-compose buildah \
  && apk add nerdctl nerdctl-bash-completion nerdctl-zsh-completion \
  && apk add kubectl kubectl-bash-completion kubectl-zsh-completion kubectx kubectx-bash-completion kubectx-zsh-completion helm helm-bash-completion helm-zsh-completion kustomize kustomize-bash-completion kustomize-zsh-completion \
  && apk add openrc

RUN rc-update add docker boot

COPY TODDELEWIS_SUDOERS /etc/sudoers.d
RUN chmod 440 /etc/sudoers.d/TODDELEWIS_SUDOERS

COPY keepalive.sh /usr/local/bin
RUN chmod 555 /usr/local/bin/keepalive.sh \
  && mkdir /var/log/keepalive \
  && chmod 777 /var/log/keepalive

RUN adduser -h /home/toddelewis -s /bin/bash -g toddelewis -D -u 42001 toddelewis

USER toddelewis

RUN git config --global user.email toddelewis@gmail.com \
  && git config --global user.name "Todd Lewis" \
  && git config --global core.autocrlf input \
  && git config --global credential.https://github.com.username "telewis" \
  && git config --global credential.helper store

EXPOSE 80 443 6443 8000 8080 8443
