ARG STRIMZI_VERSION="0.32.0"
ARG KAFKA_VERSION="3.3.1"

FROM quay.io/strimzi/kafka:${STRIMZI_VERSION}-kafka-${KAFKA_VERSION}

ARG AWS_MSK_IAM_AUTH_VERSION="1.1.6"
ENV CLASSPATH=/opt/kafka/libs/aws-msk-iam-auth-${AWS_MSK_IAM_AUTH_VERSION}-all.jar

USER root
RUN curl -sSL -o /opt/kafka/libs/aws-msk-iam-auth-${AWS_MSK_IAM_AUTH_VERSION}-all.jar https://github.com/aws/aws-msk-iam-auth/releases/download/v${AWS_MSK_IAM_AUTH_VERSION}/aws-msk-iam-auth-${AWS_MSK_IAM_AUTH_VERSION}-all.jar

COPY kafka_connect_config_generator.sh /opt/kafka/kafka_connect_config_generator.sh
COPY kafka_mirror_maker_2_connector_config_generator.sh /opt/kafka/kafka_mirror_maker_2_connector_config_generator.sh
COPY kafka_mirror_maker_consumer_config_generator.sh /opt/kafka/kafka_mirror_maker_consumer_config_generator.sh
COPY kafka_mirror_maker_producer_config_generator.sh /opt/kafka/kafka_mirror_maker_producer_config_generator.sh

RUN chmod +x /opt/kafka/kafka_connect_config_generator.sh \
 && chmod +x /opt/kafka/kafka_mirror_maker_2_connector_config_generator.sh \
 && chmod +x /opt/kafka/kafka_mirror_maker_consumer_config_generator.sh \
 && chmod +x /opt/kafka/kafka_mirror_maker_producer_config_generator.sh