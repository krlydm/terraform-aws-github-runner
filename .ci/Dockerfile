#syntax=docker/dockerfile:1.2
FROM node:14 as build
WORKDIR /lambda
RUN apt-get update \
        && apt-get install -y zip \
        && rm -rf /var/lib/apt/lists/*

FROM build as runners
COPY modules/runners/lambdas/runners /lambda
RUN --mount=type=cache,target=/lambda/node_modules,id=runners \
        yarn install && yarn dist

FROM scratch as final
COPY --from=runners                /lambda/runners.zip                /runners.zip
