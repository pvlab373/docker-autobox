FROM python:3.12.8-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    ssh \
    curl \
    wget \
    net-tools \
    tcpdump \
    nmap \
    iputils-ping \
    mtr-tiny \
    iperf3 \
    unzip \
    httpie \
    jq \
    gnupg \
    software-properties-common \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Terraform 1.9.8
RUN wget -q https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip && \
    unzip terraform_1.9.8_linux_amd64.zip -d /usr/local/bin && \
    rm terraform_1.9.8_linux_amd64.zip

# Install Ansible Core version 2.16
RUN pip install --no-cache-dir ansible-core==2.16.0

RUN ansible-galaxy collection install \
    cisco.ios \
    arista.eos \
    arista.avd \
    paloaltonetworks.panos \
    netbox.netbox \
    amazon.aws

RUN pip install --no-cache-dir \
    netmiko \
    nornir \
    pandas \
    requests \
    textfsm \
    pyyaml \
    jinja2 \
    napalm \
    scrapli \
    ntc-templates \
    jsonpath-ng \
    cryptography


WORKDIR /workspace

CMD ["bash"]
