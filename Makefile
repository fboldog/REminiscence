MACHINE= $(shell uname -s)

ifeq ($(MACHINE),Darwin)
	GL_LIBS = -framework OpenGL -lGLEW
	VORBIS_LIBS = -lvorbis
else
	GL_LIBS = -lGL -lGLEW
	VORBIS_LIBS = -lvorbisidec
endif

SDL_CFLAGS = `sdl-config --cflags`
SDL_LIBS = `sdl-config --libs`
ZLIB_LIBS = -lz

DEFINES = -DBYPASS_PROTECTION
#DEFINES = -DBYPASS_PROTECTION -DENABLE_PASSWORD_MENU -DNDEBUG

CXXFLAGS += -Wall -Wuninitialized -Wshadow -Wundef -Wreorder -Wnon-virtual-dtor -Wno-multichar
CXXFLAGS += -MMD $(SDL_CFLAGS) -DUSE_GL -DUSE_ZLIB $(DEFINES)

SRCS = collision.cpp cutscene.cpp file.cpp fs.cpp game.cpp graphics.cpp main.cpp menu.cpp \
	mixer.cpp mod_player.cpp ogg_player.cpp piege.cpp resource.cpp scaler.cpp seq_player.cpp \
	sfx_player.cpp shader.cpp staticres.cpp systemstub_sdl.cpp unpack.cpp util.cpp video.cpp

OBJS = $(SRCS:.cpp=.o)
DEPS = $(SRCS:.cpp=.d)

LIBS = $(SDL_LIBS) $(VORBIS_LIBS) $(ZLIB_LIBS) $(GL_LIBS)

-include Makefile.local

rs: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

clean:
	rm -f *.o *.d

-include $(DEPS)
