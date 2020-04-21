oc adm node-logs <hostname> --since='2020-03-30 00:00:00'

oc get all -n openshift-infra




oc get pods -A --field-selector=status.phase=Running -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq






$ oc rsh -n openshift-authentication <oauth-openshift-pod> cat /run/secrets/kubernetes.io/serviceaccount/ca.crt > ingress-ca.crt

    Login using that specific file as certificate file:

$ oc login -u username -p password https://api.ocp4.innershift.sodigital.io:6443 --certificate-authority=ingress-ca.crt











  $ oc get dc/docker-registry -o yaml -n default > dc-docker-registry.yaml
  $ oc extract secret/registry-certificates --to=/tmp -n default
  $ openssl x509 -text -noout -in /tmp/registry.crt
