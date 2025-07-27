#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -aG docker ec2-user

# Login to DockerHub
echo "${docker_password}" | docker login -u "${docker_username}" --password-stdin

# Pull and run Strapi container
docker pull ${docker_username}/strapi-app:latest
docker run -d -p 80:1337 --name strapi ${docker_username}/strapi-app:latest
