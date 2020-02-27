FROM alpine:3.11 as downloader

ENV OPERATOR_SDK_VERSION=v0.15.2

WORKDIR /app

RUN apk --update add wget unzip && \
  wget https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}/operator-sdk-${OPERATOR_SDK_VERSION}-x86_64-linux-gnu && \
  mv operator-sdk-${OPERATOR_SDK_VERSION}-x86_64-linux-gnu operator-sdk && \
  chmod a+x ./operator-sdk


FROM scratch

WORKDIR /app

COPY --from=downloader /app/operator-sdk .

CMD ["/app/operator-sdk"]
