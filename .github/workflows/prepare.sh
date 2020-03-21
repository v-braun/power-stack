echo "create generate ssh key"
mkdir -p ~/.ssh/ && chmod 700 ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
chmod 600 ~/.ssh/config
echo "$SSH_PRIV_KEY" > ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

echo "start & setup ssh agent"
eval $(ssh-agent -s)
ssh-keygen -R $VM_DOMAIN || true
ssh-keyscan -H $VM_DOMAIN >> ~/.ssh/known_hosts
ssh-add ~/.ssh/id_rsa

echo "create & use docker context"
docker context create power-stack \
    --default-stack-orchestrator "swarm" \
    --docker "host=$SSH_HOST"
docker context use power-stack