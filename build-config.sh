#!/bin/bash
cat <<EOF | oc create -f - 
kind: BuildConfig
apiVersion: build.openshift.io/v1
metadata:
  name: testapp-bc
  namespace: $2
spec:
  nodeSelector: {}
  strategy:
    type: Source
    sourceStrategy:
      from:
        kind: ImageStreamTag
        namespace: openshift
        name: 'httpd:2.4-el7'
  source:
    type: Git
    git:
      uri: 'https://github.com/martinmlkvy/testapp.git'
      ref: dev
  output:
    to:
      kind: DockerImage
      name: 'quay.io/cerveny/testapp:dev-v$1'
    pushSecret:
      name: quay-credentials
EOF