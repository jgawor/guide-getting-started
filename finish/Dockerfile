# FROM icr.io/appcafe/open-liberty:full-java11-openj9-ubi
FROM open-liberty:beta-instanton-java17-openj9-ubi-amd64

COPY --chown=1001:0 src/main/liberty/config/ /config/
COPY --chown=1001:0 target/*.war /config/apps/

RUN configure.sh
