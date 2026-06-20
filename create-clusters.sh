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
      - containerPort: 80
        hostPort: 80
        listenAddress: "0.0.0.0"
      - containerPort: 443
        hostPort: 443
        listenAddress: "0.0.0.0"
EOF