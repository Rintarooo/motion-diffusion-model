ARG PYTHON_VER=3.7.13
# https://pytorch.org/get-started/previous-versions/
ARG TORCH_VER=1.7.1
ARG TORCH_VISON_VER=0.8.2
ARG TORCH_AUDIO_VER=0.7.2
ARG CUDA_VER=11.0.3
ARG UBUNTU_VER=20.04
# 18.04

# check whether the base image exists in dockerhub repo
# https://hub.docker.com/r/nvidia/cuda
# FROM nvidia/cuda:${CUDA_VER}-base-ubuntu${UBUNTU_VER}
FROM nvidia/cuda:${CUDA_VER}-cudnn8-devel-ubuntu${UBUNTU_VER}

ENV WORK_DIR /app
WORKDIR ${WORK_DIR}

# https://freak-da.hatenablog.com/entry/2020/03/31/094140
ARG PYTHON_VER_NO_PERIODS=37
ARG PYTHON_VER
ARG TORCH_VER
ARG TORCH_VISON_VER
ARG TORCH_AUDIO_VER
ARG CUDA_VER_NO_PERIODS=110
ARG UBUNTU_VER
ARG DEBIAN_FRONTEND=noninteractive

# Install some basic utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    ca-certificates \
    sudo \
    wget \
    curl \
    vim \
    git \
    bzip2 \
    build-essential \
    vim \
    libgl1-mesa-glx \
    libglib2.0-0 \
    zlib1g-dev \
    libssl-dev \
    libffi-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHON_INSTALL_DIR /my_python/

# Install Python
RUN mkdir -p ${PYTHON_INSTALL_DIR} \
    &&  cd ${PYTHON_INSTALL_DIR} \
    &&  wget https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz \
    &&  tar -xf Python-$PYTHON_VER.tgz \
    &&  rm Python-$PYTHON_VER.tgz \
    &&  cd Python-$PYTHON_VER/ \
    &&  ./configure --enable-optimizations \
    &&  make -j$(nproc) \
    &&  make install

RUN ln -fs ${PYTHON_INSTALL_DIR}/Python-${PYTHON_VER}/python /usr/bin/python \
    && curl -kL https://bootstrap.pypa.io/get-pip.py | python 

# Install pip packages
RUN pip install --upgrade pip setuptools wheel \
    && pip install torch==${TORCH_VER}+cu${CUDA_VER_NO_PERIODS} torchvision==${TORCH_VISON_VER}+cu${CUDA_VER_NO_PERIODS} torchaudio==${TORCH_AUDIO_VER} --index-url https://download.pytorch.org/whl/cu${CUDA_VER_NO_PERIODS} \
    && pip install opencv-python numpy tqdm ninja trimesh matplotlib
    # torch-2.0.1+cu117.with.pypi.cudnn-cp310-cp310-linux_x86_64.whl
    # pip install torch==${TORCH_VER}+cu${CUDA_VER_NO_PERIODS} torchvision==0.15.1+cu{CUDA_VER_NO_PERIODS} --index-url https://download.pytorch.org/whl/cu117 \
    # pip install torch torchvision \

# RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
#     # libffi-devel \
#     libffi-dev \
# #     && pip install ftfy regex spacy \
# RUN apt install libffi-dev \
RUN pip install ftfy regex spacy \
    && python -m spacy download en_core_web_sm \
    && pip install git+https://github.com/openai/CLIP.git


# # requirements.txtの場合
# # COPY requirements.txt ${WORK_DIR}
# # COPY environment.yml ${WORK_DIR}

# # RUN pip install -r requirements.txt
# # this is heavy if your current folder is a big data storage
# # COPY . ${WORK_DIR}

# # # Install Miniconda and Python 3.x
# # ENV CONDA_AUTO_UPDATE_CONDA=false
# # ENV PATH=/home/user/miniconda/bin:$PATH
# # RUN curl -sLo ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
# #  && chmod +x ~/miniconda.sh \
# #  && ~/miniconda.sh -b -p ~/miniconda \
# #  && rm ~/miniconda.sh \
# #  && conda install -y python==$PYTHON_VERSION numpy scipy pandas matplotlib tqdm \
# #  && conda clean -ya


# # https://qiita.com/junkor-1011/items/cd7c0e626aedc335011d

# https://qiita.com/Spritaro/items/602118d946a4383bd2bb
# ローカルuser作成
ARG USER_NAME=user
ARG GROUP_NAME=user
ARG UID=1000
ARG GID=1000
ARG PIN=password
RUN groupadd -g $GID $GROUP_NAME \
    && useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USER_NAME \
    && gpasswd -a $USER_NAME sudo \
    && echo "${USER_NAME}:${PIN}" | chpasswd \
    && echo "${USER_NAME} ALL=(ALL) ALL" >> /etc/sudoers \
    && chmod g+w /etc/passwd
USER $USER_NAME



# # conda用準備
# ENV CONDA_DIR=/opt/conda \
#     CONDA_TMP_DIR=/tmp/conda \
#     HOME=/home/$USER_NAME \
#     SHELL=/bin/bash
# RUN mkdir -p $CONDA_DIR && \
#     mkdir -p $CONDA_TMP_DIR
#     # && \
#     # chown $USER_NAME:$USER_UID $CONDA_DIR && \
#     # chown $USER_NAME:$USER_UID $CONDA_TMP_DIR

# # yamlファイルの取り込み
# ARG CONDA_YAML="./environment.yml"
# COPY $CONDA_YAML /tmp/conda_packages.yml

# # USER ${USER_NAME}

# # WORKDIR $HOME

# # miniconda
# # https://repo.anaconda.com/miniconda/
# ARG MINICONDA_VERSION=py${PYTHON_VER_NO_PERIODS}_23.3.1-0-Linux-x86_64
# # latest-Linux-x86_64
# # py37_4.8.3-Linux-x86_64
# # ARG MINICONDA_MD5=751786b92c00b1aeae3f017b781018df
# ENV PATH=${CONDA_DIR}/bin:$PATH

# RUN cd /tmp && \
#     wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}.sh && \
#     /bin/bash Miniconda3-${MINICONDA_VERSION}.sh -f -b -p $CONDA_TMP_DIR && \
#     rm Miniconda3-${MINICONDA_VERSION}.sh && \
#     $CONDA_TMP_DIR/bin/conda env create -f /tmp/conda_packages.yml -p $CONDA_DIR && \
#     rm -rf $HOME/.cache/* && \
#     rm -rf $CONDA_TMP_DIR/*
#     # echo "${MINICONDA_MD5} *Miniconda3-${MINICONDA_VERSION}.sh" | md5sum -c - && \
#     # 