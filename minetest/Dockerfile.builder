FROM alpine:3.6

# build variables
ARG LDFLAGS="-lintl"

# Install Dev Dependencies
RUN \
 apk add --no-cache --virtual=build-dependencies \
	bzip2-dev \
	cmake \
	curl-dev \
	doxygen \
	g++ \
	gcc \
	gettext-dev \
	git \
	gmp-dev \
	hiredis-dev \
	icu-dev \
	irrlicht-dev \
	libjpeg-turbo-dev \
	libogg-dev \
	libpng-dev \
	libressl-dev \
	libtool \
	libvorbis-dev \
	luajit-dev \
	make \
	mesa-dev \
	openal-soft-dev \
	python-dev \
	sqlite-dev && \
apk add --no-cache --virtual=build-dependencies \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	leveldb-dev



# Clone MineTest
RUN git clone -b stable-0.4 --depth 1 https://github.com/minetest/minetest.git /tmp/minetest

# Prepare Compilation
RUN cd /tmp/minetest && \
    cmake . \
  -DRUN_IN_PLACE=TRUE \
	-DBUILD_CLIENT=FALSE \
	-DBUILD_SERVER=TRUE \
	-DENABLE_CURL=TRUE \
	-DENABLE_LEVELDB=FALSE \
	-DENABLE_LUAJIT=TRUE \
	-DENABLE_REDIS=FALSE \
	-DENABLE_SOUND=FALSE \
	-DENABLE_SYSTEM_GMP=FALSE  \
    
# Compile MineTest
RUN cd /tmp/minetest && \
 make && \
 make install
 
# Install MineTest game
RUN \
 cd /tmp/minetest/games && \
 git clone -b stable-0.4 https://github.com/minetest/minetest_game.git minetest
 
