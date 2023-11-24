#v0.1 - 24.11.2023 by @dnao
#TODO: Test + Debug, add behapy

# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set frontend to noninteractive in order to avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    libgmp-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcurl4-openssl-dev \
    libblas-dev \
    liblapack-dev \
    libgsl-dev \
    build-essential \
    r-base \
    r-base-dev

# Reset the frontend variable to its default value
ENV DEBIAN_FRONTEND=

# Clone the fastFMM repository
RUN git clone https://github.com/gloewing/fastFMM.git

# Install R packages
RUN R -e "install.packages(c('curl', 'credentials', 'httr2', 'httr', 'ragg', 'rcmdcheck', 'rversions', 'urlchecker', 'gert', 'gh', 'pkgdown', 'usethis', 'devtools', 'arrangements', 'lme4', 'parallel', 'cAIC4', 'magrittr', 'dplyr', 'mgcv', 'MASS', 'lsei', 'refund', 'stringr', 'Matrix', 'mvtnorm', 'arrangements', 'progress', 'ggplot2', 'gridExtra', 'here', 'RcppZiggurat', 'RcppGSL', 'Rfast'))"

# Install the fastFMM package from GitHub
RUN R -e "devtools::install_github('gloewing/fastFMM')"

# Set the working directory
WORKDIR /data

# Command to keep the container running
CMD ["tail", "-f", "/dev/null"]
