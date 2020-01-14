FROM openjdk:11

WORKDIR /workdir/app

ADD ./build/install/testApp .

EXPOSE 19999

ENTRYPOINT ./bin/testApp