#!/usr/bin/env bash

set -o pipefail errexit nounset

dcos package install dcos-enterprise-cli --yes --cli
dcos security org service-accounts keypair mlb-private-key.pem mlb-public-key.pem
dcos security org service-accounts create -p mlb-public-key.pem -d "Marathon-LB service account" mlb-principal || true
dcos security org service-accounts show mlb-principal
dcos security secrets create-sa-secret --strict mlb-private-key.pem mlb-principal mlb-secret || true
dcos security secrets list /
dcos security secrets get /mlb-secret --json | jq -r .value | jq
rm -rf mlb-private-key.pem
curl -X PUT --cacert dcos-ca.crt -H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:services:%252F -d '{"description":"Allows access to any service launched by the native Marathon instance"}' -H 'Content-Type: application/json' || true
curl -X PUT --cacert dcos-ca.crt -H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:admin:events -d '{"description":"Allows access to Marathon events"}' -H 'Content-Type: application/json' || true
curl -X PUT --cacert dcos-ca.crt -H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:services:%252F/users/mlb-principal/read || true
curl -X PUT --cacert dcos-ca.crt -H "Authorization: token=$(dcos config show core.dcos_acs_token)" $(dcos config show core.dcos_url)/acs/api/v1/acls/dcos:service:marathon:marathon:admin:events/users/mlb-principal/read || true
tee config.json <<EOF
{
    "marathon-lb": {
        "secret_name": "mlb-secret",
        "marathon-uri": "https://master.mesos:8443"
    }
}
EOF
dcos package install --options=config.json marathon-lb --yes
