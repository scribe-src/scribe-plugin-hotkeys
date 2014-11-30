#
# scribe-plugin-hotkeys
#
PROJECT=HotKeys
SRC_DIR=./src
BUILD_DIR=./build
CC=gcc

OSX_FRAMEWORKS=-framework Foundation -framework Carbon
OSX_OUT=$(BUILD_DIR)/osx/$(PROJECT).framework/$(PROJECT)
OSX_INC=-I$(SRC_DIR)/osx -I./deps/scribe-platform-osx/src \
	-I./deps/scribe-platform-osx/deps/jscocoa/JSCocoa

osx:
	mkdir -p $(BUILD_DIR)/osx/$(PROJECT).framework/Resources/BridgeSupport
	mkdir -p $(BUILD_DIR)/osx/$(PROJECT).framework/Headers
	$(CC) $(SRC_DIR)/osx/**.m $(OSX_INC) -undefined suppress $(OSX_FRAMEWORKS) \
		-dynamiclib -flat_namespace -arch x86_64 -o $(OSX_OUT).x64
	$(CC) $(SRC_DIR)/osx/**.m $(OSX_INC) -undefined suppress $(OSX_FRAMEWORKS) \
		-dynamiclib -flat_namespace -arch i386 -o $(OSX_OUT).x86
	lipo -create $(OSX_OUT).x64 $(OSX_OUT).x86 -output $(OSX_OUT)
	rm -f $(OSX_OUT).x64 $(OSX_OUT).x86
	cp $(SRC_DIR)/osx/HotKeys.h $(BUILD_DIR)/osx/$(PROJECT).framework/Headers
	gen_bridge_metadata -f `pwd`/$(BUILD_DIR)/osx/$(PROJECT).framework -o \
		$(BUILD_DIR)/osx/$(PROJECT).framework/Resources/BridgeSupport/$(PROJECT).bridgesupport

osx-test:


clean:
	rm -rf $(BUILD_DIR)

