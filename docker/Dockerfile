# syntax=docker/dockerfile:1

ARG VERSION=25.12
FROM nvcr.io/nvidia/pytorch:${VERSION}-py3

# Install utils
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        sudo zsh zoxide fzf eza stow direnv \
    && rm -rf /var/lib/apt/lists/*

# Install tileiras
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-tileiras-13-1_13.1.80-1_amd64.deb \
    && dpkg -i cuda-tileiras-13-1_13.1.80-1_amd64.deb \
    && rm cuda-tileiras-13-1_13.1.80-1_amd64.deb

# Fix fzf completion and key-bindings missing in Ubuntu
ADD --chmod=0644 https://raw.githubusercontent.com/junegunn/fzf/refs/tags/0.44.1/shell/key-bindings.zsh /usr/share/doc/fzf/examples/key-bindings.zsh
ADD --chmod=0644 https://raw.githubusercontent.com/junegunn/fzf/refs/tags/0.44.1/shell/completion.zsh /usr/share/doc/fzf/examples/completion.zsh

# Setup sudo
RUN echo ubuntu ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu

# Setup user dotfiles
USER ubuntu
ADD --chown=1000:1000 https://github.com/chengjiagan/dotfiles.git /home/ubuntu/dotfiles
RUN /home/ubuntu/dotfiles/install/install-omz.sh \
    && rm /home/ubuntu/.zshrc \
    && stow -d /home/ubuntu/dotfiles/config -t /home/ubuntu --no-folding .

CMD ["/usr/bin/zsh"]
