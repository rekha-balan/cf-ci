#Base image for kube yaml installer
FROM opensuse:42.3

# Install: ruby, unzip, openssh, sshpass, vim, nano, curl, kubectl
# Install: wget, tar, helm, direnv
# NOTE: The `utilities` repo is added for access to `direnv`.
#
RUN true \
    && zypper --non-interactive addrepo http://download.opensuse.org/repositories/utilities/openSUSE_Leap_42.3/utilities.repo \
    && zypper --non-interactive --gpg-auto-import-keys refresh \
    && zypper --non-interactive install ruby \
    unzip \
    openssh \
    sshpass \
    vim \
    nano \
    curl \
    wget \
    tar \
    direnv \
    bash-completion docker-bash-completion systemd-bash-completion \
    && helm_version=v2.8.2 \
    && wget https://kubernetes-helm.storage.googleapis.com/helm-${helm_version}-linux-amd64.tar.gz -O - | tar xz -C /usr/local/bin --strip-components=1 linux-amd64/helm \
    && chmod a+x /usr/local/bin/helm \
    && echo "eval \"\$(direnv hook bash)\"" >> ~/.bashrc \
    && echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc \
    && echo "source <(helm completion bash)" >> ~/.bashrc \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.9.8/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && echo "source <(kubectl completion bash)" >> ~/.bashrc \
    && zypper clean -a \
    && true

RUN true \
    && wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O /usr/local/bin/jq \
    && chmod +x /usr/local/bin/jq

RUN true \
    && wget "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=6.34.0" -O - | tar xz -C /usr/local/bin cf \
    && chmod a+x /usr/local/bin/cf

RUN true \
    && curl -L https://github.com/SUSE/stampy/releases/download/0.0.0/stampy-0.0.0.22.gbb93bf3.linux-amd64.tgz | tar xz stampy \
    && mv stampy /usr/local/bin/stampy \
    && chmod +x /usr/local/bin/stampy
