#!/usr/bin/env bash

# ECR URI regex pattern
ecr_regex_pattern="^[0-9]{12}\.dkr\.ecr\.[a-z0-9-]+\.amazonaws\.com\/.+"

if [[ $INPUT_IMAGE =~ $ecr_regex_pattern ]]; then
aws ecr get-login-password --region $INPUT_AWS_REGION | docker login --username AWS --password-stdin $INPUT_REGISTRY
elif [ ! -z $INPUT_USERNAME ]; then
echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

if [ ! -z $INPUT_DOCKER_NETWORK ];
then INPUT_OPTIONS="$INPUT_OPTIONS --network $INPUT_DOCKER_NETWORK"
fi

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "${INPUT_RUN//$'\n'/;}"
