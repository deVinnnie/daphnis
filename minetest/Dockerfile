FROM alpine:3.5

ENV GAMEID=minetest_game

VOLUME /home/minetest/worlds

# Runtime packages
RUN apk add --no-cache \
	cmake \
    g++ \
    gcc \
    curl \
    gmp \
    hiredis \
    libgcc \
    libintl \
    libstdc++ \
    luajit \
    lua-socket \
    sqlite \
    git \
	make \
    sqlite-libs

# http://libspatialindex.github.io/install.html
# Clone spatialindex    
RUN git clone https://github.com/libspatialindex/libspatialindex /tmp/spatialindex

# Compile spatialindex 
RUN \
cd /tmp/spatialindex && \
cmake . \
	-DCMAKE_INSTALL_PREFIX=/usr && \
make && \
make install

COPY minetest-bin /home/minetest/minetest-bin/
#COPY spatialindex /usr/spatialindex/
COPY minetest-server.sh /home/minetest

EXPOSE 30000

RUN apk add --update bash \
  && rm -rf /var/cache/apk/* \
  && adduser -D minetest minetest \
  && chmod +x /home/minetest/minetest-server.sh \
  && chmod +x /home/minetest/minetest-bin/bin/minetestserver

ENTRYPOINT ["/home/minetest/minetest-server.sh"]

USER minetest
