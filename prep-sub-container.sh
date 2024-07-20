#~/bin/bash

# register with subscription manager first

dnf install -y python3-hawkey git python pip skopeo
pip install https://github.com/konflux-ci/rpm-lockfile-prototype/archive/refs/heads/main.zip
git clone https://github.com/brianwcook/trusted-artifacts.git


cd trusted-artifacts
git checkout trustee
id=6823129720431929499
key="/etc/pki/entitlement/$id-key.pem"  
cert="/etc/pki/entitlement/$id.pem"
sed -i "s|{{entitlement-key.pem}}|$key|g" ubi9-redhat.repo
sed -i "s|{{entitlement.pem}}|$cert|g" ubi9-redhat.repo
sed -i "s|{{entitlement-key.pem}}|$key|g" ubi9-redhat-src.repo
sed -i "s|{{entitlement.pem}}|$cert|g" ubi9-redhat-src.repo


rpm-lockfile-prototype -f Containerfile rpms.in.yaml --outfile rpms.lock.yaml

/etc/pki/entitlement/1436274180341277879.pem