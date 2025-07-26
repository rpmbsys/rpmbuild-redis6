ARG os=10.0.20250606
FROM aursu/rpmbuild:${os}-build

USER root

RUN dnf -y install \
        clang \
        openssl-devel \
        systemd-devel \
        tcl \
    && dnf clean all && rm -rf /var/cache/dnf

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "redis.spec"]
CMD ["-ba"]
