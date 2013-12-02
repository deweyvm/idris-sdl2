CC=gcc
CFLAGS=-g -O0 -w
LIBS=-lSDL2
SRCS = csrc/idris_SDL_video.c \
       csrc/idris_SDL_mouse.c \
       csrc/idris_SDL_clipboard.c \
       csrc/idris_SDL_bits.c \
       csrc/idris_SDL_gamecontroller.c \
       csrc/idris_SDL_surface.c \
       csrc/idris_SDL_render.c \
       csrc/idris_SDL_events.c

OBJS = $(SRCS:.c=.o)

all: $(OBJS)
	~/.cabal/bin/idris --ibcsubdir dist driver.idr -o driver && ./driver

.c.o:
	$(CC) $(CFLAGS) -c $< $(LIBS)

clean:
	rm -rf driver *~ *.ibc *.o
