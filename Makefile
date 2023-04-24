SRC_DIR := src
OBJ_DIR := .obj
BIN_DIR := bin
CC := g++

EXE := $(BIN_DIR)/program.exe
SRC := $(wildcard $(SRC_DIR)/*.cpp)
OBJ := $(SRC:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

CPPFLAGS 	:= -Iinclude -MMD -MP
CFLAGS		:= -Wall
LDFLAGS 	:= 
LDLIBS 		:= 

all: $(EXE)

$(EXE): $(OBJ)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(OBJ_DIR) $(BIN_DIR):
	mkdir $@

-include $(OBJ:.o=.d)

run:
	$(EXE)

V_OUT = .logs/valgrind-out.txt

V_FLAGS = --leak-check=full \
			--show-leak-kinds=all \
			--log-file=$(V_OUT) \
			--track-origins=yes \
			-s 
runV:
	valgrind $(V_FLAGS) $(EXE) && cat ./$(V_OUT)

clean:
	rmdir /s /q $(OBJ_DIR)