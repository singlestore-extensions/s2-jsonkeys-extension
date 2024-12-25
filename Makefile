# Tools
WIT_BINDGEN = wit-bindgen

# Project name
NAME = s2-jsonkeys-extension

# Directories
BUILD_DIR = build
SRC_DIR = src
DEBUG_PATH = target/wasm32-wasip1/debug
RELEASE_PATH = target/wasm32-wasip1/release

# Files
WASM_RELEASE_FILE = $(RELEASE_PATH)/extension.wasm
WASM_DEBUG_FILE = $(DEBUG_PATH)/extension.wasm
TAR_FILE = $(BUILD_DIR)/$(NAME).tar
WIT_FILE = $(BUILD_DIR)/extension.wit

# Phony targets
.PHONY: all clean debug release test

# Default target
all: debug

debug: $(WASM_DEBUG_FILE)
	cp $(WASM_DEBUG_FILE) $(BUILD_DIR)/extension.wasm

release: $(WASM_RELEASE_FILE)
	cp $(WASM_RELEASE_FILE) $(BUILD_DIR)/extension.wasm
	tar cvf $(TAR_FILE) -C $(BUILD_DIR) $(NAME).sql extension.wasm extension.wit 

# Build the WebAssembly module
$(WASM_DEBUG_FILE):
	cargo build --target wasm32-wasip1

$(WASM_RELEASE_FILE):
	cargo build --target wasm32-wasip1 --release

# Clean build artifacts
clean:
	cargo clean
	rm -f $(BUILD_DIR)/extension.wasm
	rm -f $(BUILD_DIR)/$(NAME).tar

# Run tests
test: $(WASM_DEBUG_FILE)
	writ --expect 8 --wit $(WIT_FILE) $(WASM_DEBUG_FILE) $(NAME) 2 3
	@echo PASS
	writ --expect 1 --wit $(WIT_FILE) $(WASM_DEBUG_FILE) $(NAME) 2 0
	@echo PASS
	writ --expect 0 --wit $(WIT_FILE) $(WASM_DEBUG_FILE) $(NAME) 0 2
	@echo PASS