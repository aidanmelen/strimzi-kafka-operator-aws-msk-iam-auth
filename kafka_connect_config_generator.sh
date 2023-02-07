#!/usr/bin/env bash
set -e

# Write the config file
cat <<EOF
# Bootstrap servers
bootstrap.servers=${KAFKA_CONNECT_BOOTSTRAP_SERVERS}
# REST Listeners
rest.port=8083
rest.advertised.host.name=$(hostname -I | awk '{ print $1 }')
rest.advertised.port=8083
# Plugins
plugin.path=${KAFKA_CONNECT_PLUGIN_PATH}
# Provided configuration
${KAFKA_CONNECT_CONFIGURATION}

# AWS MSK SASL/IAM
security.protocol=SASL_SSL
sasl.mechanism=AWS_MSK_IAM
sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
admin.security.protocol=SASL_SSL
admin.sasl.mechanism=AWS_MSK_IAM
admin.sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
admin.sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
producer.security.protocol=SASL_SSL
producer.sasl.mechanism=AWS_MSK_IAM
producer.sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
producer.sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
consumer.security.protocol=SASL_SSL
consumer.sasl.mechanism=AWS_MSK_IAM
consumer.sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
consumer.sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler

# Additional configuration
consumer.client.rack=${STRIMZI_RACK_ID}
EOF