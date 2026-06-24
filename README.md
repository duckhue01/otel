TA:
- service discovery
- load distribution
- CR for scrape config



deploy 

kubectl kustomize --enable-helm dev/application | kubectl apply --server-side -f -

kubectl kustomize --enable-helm dev/monitoring | kubectl apply --server-side -f -



sumologic vendor lockin 
- helm chart coupling
- lossing the vendor-agnostic benefits of Otel



helm repo add sumologic https://sumologic.github.io/sumologic-kubernetes-collection
helm repo update

helm template \
  -f sumo-value.yml.yaml \
  sumologic/sumologic > rendered-manifests.yaml


cat <<EOF | kind create cluster --name application --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerAddress: "0.0.0.0"
  apiServerPort: 6443
# Inject your LAN IP into the API Server's TLS Certificate
kubeadmConfigPatches:
  - |
    kind: ClusterConfiguration
    apiServer:
      certSANs:
        - "192.168.1.241"
EOF



cat <<EOF | kind create cluster --name monitoring --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerAddress: "0.0.0.0"
  apiServerPort: 6444
# Inject your LAN IP into the API Server's TLS Certificate
kubeadmConfigPatches:
  - |
    kind: ClusterConfiguration
    apiServer:
      certSANs:
        - "192.168.1.241"
nodes:
  - role: control-plane
    # Expose HTTP/HTTPS ports to the LAN
    extraPortMappings:
      - containerPort: 30431
        hostPort: 30431
        listenAddress: "0.0.0.0"
EOF


## File Structure


## Development
YAML language server suggesion & validation