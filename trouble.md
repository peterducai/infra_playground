oc adm node-logs <hostname> --since='2020-03-30 00:00:00'

oc get all -n openshift-infra




oc get pods -A --field-selector=status.phase=Running -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq
