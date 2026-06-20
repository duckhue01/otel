TA:
- service discovery
- load distribution
- CR for scrape config


Sumo API key
suaRNxrpP04FUL
Gn7Q6LP3DG06URgUZcUsW1OfegH44OBUnezIdps5LKKSzHFQzVNAo75E1aKMYxZv



deploy 

kubectl kustomize --enable-helm local | kubectl apply --server-side -f -




sumologic vendor lockin 
- helm chart coupling
- lossing the vendor-agnostic benefits of Otel



helm repo add sumologic https://sumologic.github.io/sumologic-kubernetes-collection
helm repo update

helm template \
  -f /Users/duckhue01/obv/otel/value.yaml \
  sumologic/sumologic > rendered-manifests.yaml