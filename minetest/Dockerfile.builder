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
RUN git clone --depth 1 https://github.com/minetest/minetest.git /tmp/minetest

# Prepare Compilation
RUN cd /tmp/minetest && \
    cmake . \
    -DRUN_IN_PLACE=TRUE \
	-DBUILD_CLIENT=0 \
	-DBUILD_SERVER=1 \
	-DENABLE_CURL=1 \
	-DENABLE_LEVELDB=0 \
	-DENABLE_LUAJIT=1 \
	-DENABLE_REDIS=0 \
	-DENABLE_SOUND=0 \
	-DENABLE_SYSTEM_GMP=1
    
# Compile MineTest
RUN cd /tmp/minetest && \
 make && \
 make install
 
# Install MineTest game
RUN \
 cd /tmp/minetest/games && \
 git clone -b stable-0.4 https://github.com/minetest/minetest_game.git minetest
 
