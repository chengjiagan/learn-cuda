#! /bin/sh
# start container

IMAGE_NAME="learn-cuda"
CONTAINER_NAME="learn-cuda"

STORAGE_PATH=${HOME}/.cache/container/learn-cude
mkdir -p ${STORAGE_PATH}

docker buildx build \
    --file docker/Dockerfile \
    --build-arg VERSION=25.12 \
    --tag ${IMAGE_NAME} \
    docker

docker run --interactive --tty --rm \
    --name ${CONTAINER_NAME} \
    --hostname learn-cuda-$(hostname) \
    --gpus all \
    --ipc=host \
    --ulimit memlock=-1 --ulimit stack=67108864 \
    --cap-add=SYS_ADMIN --cap-add=SYS_PTRACE \
    --env TERM=xterm-256color \
    --env HISTFILE=/home/ubuntu/storage/zsh_history \
    --env _ZO_DATA_DIR=/home/ubuntu/storage \
    --mount type=bind,source=${PWD},target=/workspace/learn-cuda \
    --mount type=bind,source=${HOME}/.ssh,target=/home/ubuntu/.ssh \
    --mount type=bind,source=${STORAGE_PATH},target=/home/ubuntu/storage \
    --workdir /workspace/learn-cuda \
    ${IMAGE_NAME}
