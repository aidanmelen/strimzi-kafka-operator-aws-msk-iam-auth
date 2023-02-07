# strimzi-kafka-operator-aws-msk-iam-auth

This repository contains a pattern for extending the `kafka-base` image from the [strimzi-kafka-operator](https://github.com/strimzi/strimzi-kafka-operator/tree/main/docker-images/kafka-based) to support SASL/IAM authentication mechanism for AWS MSK.


This pattern utilizes hardcoded authentication mechanism properties for SASL/IAM, thus rendering the `spec.authentication.mechanism` values will be ignored.

## Examples

Kafka Connect

```yaml
apiVersion: kafka.strimzi.io/v1beta2
kind: KafkaConnect
metadata:
  name: my-connect
spec:
  image: aidanmelen/strimzi-kafka-operator-aws-msk-iam-auth:0.33.0-kafka-3.3.2-aws-latest
  replicas: 1
  bootstrapServers: "${BOOTSTRAP_BROKERS_SASL_IAM}"
  config:
    group.id: connect-cluster
    offset.storage.topic: _connect-storage
    config.storage.topic: _connect-offset
    status.storage.topic: _connect-status
  template:
  
    # Uncomment for EKS IRSA credentials
    # serviceAccount:
    #   metadata:
    #     annotations:
    #       "eks.amazonaws.com/role-arn": "${AWS_ROLE_ARN}"
    
    # Uncomment for IAM User credentials
    # connectContainer:
    #   env:        
    #     - name: AWS_ACCESS_KEY_ID
    #       value: "${AWS_ACCESS_KEY_ID}"
    #     - name: AWS_SECRET_ACCESS_KEY
    #       value: "${AWS_SECRET_ACCESS_KEY}"

```