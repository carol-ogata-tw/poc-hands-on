FROM ubuntu:20.04

# Variables
ARG ANSIBLE_DIR="/etc/ansible"
ARG ANSIBLE_REPO_DIR="."
ARG SSHKEY_DEST_FILE="/root/.ssh/id_rsa"
ARG SSHKEY_SOURCE_FILE
ARG EC2_IP
ARG EC2_USER

# Install dependencies
RUN apt-get update \
    && apt-get install software-properties-common vim netcat curl unzip -y \
    && add-apt-repository --yes --update ppa:ansible/ansible \
    && DEBIAN_FRONTEND=noninteractive apt-get install ansible -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set directories
RUN mkdir -p "${ANSIBLE_DIR}/inventory" \
    && mkdir -p "${ANSIBLE_DIR}/playbooks" \
    && mkdir -p "${ANSIBLE_DIR}/vault-files" \
    && mkdir -p "/root/.ssh"

# Copy inventory, playbooks, vault files
COPY ${ANSIBLE_REPO_DIR}/install_vault.yaml ${ANSIBLE_DIR}/playbooks/
COPY ${ANSIBLE_REPO_DIR}/vault-files/vault.service ${ANSIBLE_DIR}/vault-files/
COPY ${ANSIBLE_REPO_DIR}/vault-files/vault.hcl ${ANSIBLE_DIR}/vault-files/

# Copy SSH key
RUN echo "${SSHKEY_SOURCE_FILE}" > ${SSHKEY_DEST_FILE}
RUN chmod 600 ${SSHKEY_DEST_FILE}

# Set ansible configuration file
RUN echo "[defaults]\nhost_key_checking = False\ninventory = ./inventory" > ${ANSIBLE_DIR}/ansible.cfg

# Set hosts file
RUN echo "[servers]\nec2 ansible_host=${EC2_IP} ansible_user=${EC2_USER}" > ${ANSIBLE_DIR}/inventory/hosts

# END FILE

# /etc/ansible/
# ├── inventory/
# │   └── hosts            # Inventory file listing target hosts
# ├── playbooks/
# │   └── deploy.yml       # Playbook to be run
# │   └── setup.yml        # Another playbook
# └── ansible.cfg   

# docker build --build-arg SSHKEY_SOURCE_FILE="$SSHKEY_SOURCE_FILE" --build-arg EC2_IP="$EC2_IP" --build-arg EC2_USER="$EC2_USER" --rm -t ansible-vault . 

# docker build --build-arg SSHKEY_SOURCE_FILE="$SSHKEY_SOURCE_FILE" -t ansible-vault .

# docker run -it ansible-vault bash

# docker run ansible-vault ansible-playbook -vvv /etc/ansible/playbooks/install_vault.yaml -i /etc/ansible/inventory/hosts --private-key /root/.ssh/id_rsa

  