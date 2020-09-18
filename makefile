CC=emcc
SRC=renderer.cpp
CFLAGS=-Werror -std=c++11 -Os -g0
EMSCRIPTEN_FLAGS=-s DEMANGLE_SUPPORT=1 \
        --bind -Os \
        -s SINGLE_FILE=1 \
        -s FULL_ES2=1 \
        -s USE_WEBGL2=1 \
        -s MIN_WEBGL_VERSION=2 \
        -s MAX_WEBGL_VERSION=2 \
        -s USE_GLFW=3 \
        -s FILESYSTEM=0 \
        -s TOTAL_MEMORY=134217728 \
	-s EXPORTED_FUNCTIONS='["_initializeOpenGL", "_render", "_loadJPEGImage"]'
RENDERER_NAME=renderer
OUTPUT=$(RENDERER_NAME).js

all: $(SRC) $(OUTPUT)

$(OUTPUT): $(SRC)
	$(CC) $(SRC) $(CFLAGS) $(EMSCRIPTEN_FLAGS) -o $(OUTPUT)

clean:
	rm -f $(OUTPUT)
	rm -f $(OUTPUT).mem
	rm -f $(OUTPUT).map
	rm -f $(RENDERER_NAME).wasm
	rm -f $(RENDERER_NAME).wasm.map
	rm -f $(RENDERER_NAME).wast
