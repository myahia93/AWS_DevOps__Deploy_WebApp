FROM ubuntu:latest

# Update & install ansible packer
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl gnupg2 && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(echo bionic) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y packer ansible && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
