FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# install mise, which will be used to install required packages
COPY --from=jdxcode/mise /usr/local/bin/mise /usr/local/bin/

# make sure mise is activated in both zsh and bash. Might be overridden by a user's dotfiles.
RUN echo 'eval "$(mise activate bash)"' >> /home/vscode/.bashrc && \
  echo 'eval "$(mise activate zsh)"' >> /home/vscode/.zshrc

# create developer workspace directory and set default user
RUN mkdir /workspaces && \
  chown vscode:vscode /workspaces
USER vscode

# install required packages
COPY mise.toml /mise.toml
COPY mise.local.toml /mise.local.toml
RUN /usr/local/bin/mise trust /mise.toml && \
  /usr/local/bin/mise install

# install configs
RUN git clone https://github.com/SawyerHopkins/podman-config-nvim.git /home/vscode/.config/nvim

# launch settings
WORKDIR /workspaces
