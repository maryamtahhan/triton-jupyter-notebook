# Use an official Python runtime as a parent image
FROM registry.access.redhat.com/ubi9/python-312

ARG USERNAME=1001
ARG USER_UID=1000
ARG USER_GID=$USER_UID

USER 0
COPY user.sh user.sh
# Create the user
RUN ./user.sh -u $USERNAME -g $USER_GID
# Set the user
USER $USERNAME

ENV PYTHON_VERSION=3.12 \
    PATH=$HOME/.local/bin/:$PATH \
    PYTHONUNBUFFERED=1 \
    TRITON_CPU_BACKEND=1

RUN dnf update -y && \
    dnf -y install clang cmake lld ninja-build;

# Set the working directory to /app
WORKDIR /
RUN echo "export MAX_JOBS=$(nproc --all)" >> "${HOME}"/.bashrc
RUN git clone https://github.com/triton-lang/triton-cpu.git
WORKDIR /triton-cpu
# Install dependencies
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install ninja cmake wheel pybind11 torch
RUN git submodule init
RUN git submodule update
RUN pip install -e python
RUN pip install -e './python[tutorials]'


# Install Jupyter Notebook
RUN pip install jupyter

# Make port 8888 available to the world outside this container
EXPOSE 8888

WORKDIR /notebooks
# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# docker build --build-arg USERNAME=$USER -t triton-jupyter -f Dockerfile .
