#
# scribe-plugin-hotkeys
#
PROJECT=HotKeys
SRC_DIR=./src
BUILD_DIR=./build
CC=gcc

OSX_FRAMEWORKS=-framework Foundation -framework Carbon
OSX_OUT=$(BUILD_DIR)/osx/plugin.dylib
OSX_INC=-I$(SRC_DIR)/osx -I./deps/scribe-platform-osx/src \
	-I./deps/scribe-platform-osx/deps/jscocoa/JSCocoa

JS_TMP=/tmp/HotKeys.js
JS_FILE=./src/HotKeys.js

# we use linker flags to shove our javascript 
ADD_DATA=-sectcreate __DATA __js $(JS_TMP)
CFLAGS=-undefined suppress -dynamiclib -flat_namespace $(ADD_DATA)

.PHONY: init clean

osx: init
	mkdir -p build/osx
	# build once so that we can generate bridgesupport files
	$(CC) $(SRC_DIR)/osx/**.m $(OSX_INC) $(OSX_FRAMEWORKS) $(CFLAGS) \
		-arch x86_64 -o $(OSX_OUT).x64
	$(CC) $(SRC_DIR)/osx/**.m $(OSX_INC) $(OSX_FRAMEWORKS) $(CFLAGS) \
		-arch i386 -o $(OSX_OUT).x86
	lipo -create $(OSX_OUT).x64 $(OSX_OUT).x86 -output $(OSX_OUT)
	rm -f $(OSX_OUT).x64 $(OSX_OUT).x86

init:
	# the linker does not NULL terminate the JS_FILE, which is
	# necessary for our program to treat it as a string
	cp $(JS_FILE) $(JS_TMP)
	printf "\x00" >> $(JS_TMP)

clean:
	rm -rf $(BUILD_DIR)
