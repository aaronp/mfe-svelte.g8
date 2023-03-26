#!/usr/bin/env bash
export TAG=\${TAG:-0.0.1}
export IMG=\${IMG:-$organization;format="lower"$/$name;format="lower,hyphen"$:\$TAG}
export PORT=\${PORT:-3000}


build() {
    echo "Building \$IMG..."
    docker build --tag \$IMG .
    echo "Built \$IMG. To run:"
    echo ""
    echo "docker run -it -p \$PORT:80 \$IMG"
    echo ""
    echo "And open http://localhost:\$PORT/bundle.js or http://localhost:\$PORT/bundle.css"
}

push() { 
    docker push \$IMG 
}

run() {
    yarn 
    yarn dev
}

runDocker() {
    echo "docker run -it --rm -p \$PORT:80 -d \$IMG"
    id=`docker run -it --rm -p \$PORT:80 -d \$IMG`
    cat > kill.sh <<EOL
docker kill \$id
# clean up after ourselves
rm kill.sh
EOL
    chmod +x kill.sh

    echo "Running on port \$PORT --- stop server using ./kill.sh"
}

installArgo() {
    APP=\${APP:-pinot-web}
    BRANCH=\${BRANCH:-`git rev-parse --abbrev-ref HEAD`}

    echo "creating \$APP"
    
    kubectl get namespace $namespace$ || kubectl create namespace $namespace$

    # beast mode :-)
    argocd app create \$APP \
    --repo https://github.com/$repo$.git \
    --path k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace $namespace$ \
    --sync-policy automated \
    --auto-prune \
    --self-heal \
    --revision \$BRANCH

}