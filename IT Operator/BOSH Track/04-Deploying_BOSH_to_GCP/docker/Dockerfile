FROM ubuntu:14.04
RUN apt-get update && apt-get install -y --force-yes git \
  apt-transport-https \
  curl \
  build-essential \
  zlibc \
  zlib1g-dev \
  ruby \
  ruby-dev \
  openssl \
  libxslt-dev \
  libxml2-dev \
  libssl-dev \
  libreadline6 \
  libreadline6-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  unzip \
  && rm -rf /var/lib/apt/lists/*
RUN curl https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.16-linux-amd64 -o bosh \
&& chmod +x bosh \
&& mv bosh /usr/local/bin/bosh
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
&& echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
&& apt-get update \
&& apt-get install -y google-cloud-sdk \
&& rm -rf /var/lib/apt/lists/*
RUN curl -L -J https://github.com/cloudfoundry/bosh-bootloader/releases/download/v3.1.0/bbl-v3.1.0_linux_x86-64 -o /usr/local/bin/bbl && chmod +x /usr/local/bin/bbl
RUN curl -O https://releases.hashicorp.com/terraform/0.9.5/terraform_0.9.5_linux_amd64.zip && unzip terraform_0.9.5_linux_amd64.zip && mv terraform /usr/local/bin/terraform
