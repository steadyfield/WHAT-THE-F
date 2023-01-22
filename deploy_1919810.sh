#!/bin/sh

mkdir $HOME/.android && cp debug.keystore $HOME/.android

sudo apt-get update
sudo apt install -y make unzip python3 ccache imagemagick openjdk-8-jdk openjdk-8-jre ant-contrib sshpass python3-websocket python3-pip
pip install vpk
wget https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip -o /dev/null
unzip android-ndk-r10e-linux-x86_64.zip > /dev/null
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/clang+llvm-11.1.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz -o /dev/null
tar xvf clang+llvm-11.1.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz > /dev/null
mv clang+llvm-11.1.0-x86_64-linux-gnu-ubuntu-16.04 clang/
export PATH=$(pwd)/clang/bin:$PATH

mv android-ndk-r10e ndk/
export ANDROID_NDK_HOME=$(pwd)/ndk

git clone --depth 1 https://github.com/steadyfield/source-engine-ci/ --recursive
git clone --depth 1 https://gitlab.com/LostGamer/android-sdk
export ANDROID_HOME=$(pwd)/android-sdk/
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

mkdir -p libs/ apks/
git clone --recursive --depth 1 https://github.com/steadyfield/srceng-android

#build()
#{
	MOD_NAME=$1
	MOD_VER=$2
	APP_NAME=$3
	VPK_NAME=$4
	VPK_VERSION=$5


#32 bit
	cd source-engine-ci/
	./waf configure -T release --android=armeabi-v7a-hard,host,21 --prefix=android/ --togles --disable-warns || (cat build/config.log;exit)
	./waf install || exit
	mkdir -p ../libs/$1

	mkdir -p ../libs/$1/armeabi-v7a

	cp android/lib/armeabi-v7a/libtier0.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libvstdlib.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libsteam_api.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libtogl.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libdatacache.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libvaudio_minimp3.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libengine.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libfilesystem_stdio.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libclient.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libserver.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libGameUI.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libinputsystem.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/liblauncher.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libmaterialsystem.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libshaderapidx9.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libstdshader_dx9.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libscenefilecache.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libServerBrowser.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libsoundemittersystem.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libstudiorender.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libvgui2.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libvguimatsurface.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libvideo_services.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libvphysics.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libvtex_dll.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libvaudio_opus.so ../libs/$1/armeabi-v7a
	cp android/lib/armeabi-v7a/libSDL2.so ../libs/$1/armeabi-v7a
	rm -rf android/

#64 bit
	./waf configure -T release --android=aarch64,host,21 -8 --prefix=android/ --togles --disable-warns || (cat build/config.log;exit)
	./waf install || exit
	mkdir -p ../libs/$1/arm64-v8a

	cp android/lib/arm64-v8a/libtier0.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libvstdlib.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libsteam_api.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libtogl.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libdatacache.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libvaudio_minimp3.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libengine.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libfilesystem_stdio.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libclient.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libserver.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libGameUI.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libinputsystem.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/liblauncher.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libmaterialsystem.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libshaderapidx9.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libstdshader_dx9.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libscenefilecache.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libServerBrowser.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libsoundemittersystem.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libstudiorender.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libvgui2.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libvguimatsurface.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libvideo_services.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libvphysics.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libvtex_dll.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libvaudio_opus.so ../libs/$1/arm64-v8a
	cp android/lib/arm64-v8a/libSDL2.so ../libs/$1/arm64-v8a
	
	rm -rf android/

	cd ../srceng-android/
	git checkout .
	sed -e "s/MOD_REPLACE_ME/$MOD_NAME/g" -i AndroidManifest.xml src/me/nillerusr/LauncherActivity.java
	sed -e "s/APP_NAME/$APP_NAME/g" -i res/values/strings.xml
	sed -e "s/1.05/$MOD_VER/g" -i AndroidManifest.xml

	scripts/conv.sh ../resources/$MOD_NAME/ic_launcher.png

	mkdir -p libs/arm64-v8a/
	mkdir -p libs/armeabi-v7a/

	cp -r ../libs/$MOD_NAME/arm64-v8a libs/
	cp -r ../libs/$MOD_NAME/armeabi-v7a libs/

	if ! [ -z $VPK_NAME ];then
		mkdir -p assets
		vpk -c ../resources/$MOD_NAME/vpk assets/$VPK_NAME
		sed -e "s/PACK_NAME/$VPK_NAME/g" -i src/me/nillerusr/ExtractAssets.java
		sed -e "s/1337/$VPK_VERSION/g" -i src/me/nillerusr/ExtractAssets.java
	fi

	ant debug || exit 1
	#OUT=$(curl --upload-file bin/srcmod-debug.apk https://transfer.sh/$MOD_NAME-$MOD_VER.apk)
	curl --upload-file bin/srcmod-debug.apk https://transfer.sh/$MOD_NAME-$MOD_VER.apk

#}
