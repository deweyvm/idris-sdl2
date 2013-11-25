CC=gcc
CFLAGS=-g -O0
LIBS=-lSDL2
SRCS = SDL/idris_SDL_video.c \
       SDL/idris_SDL_mouse.c \
       SDL/idris_SDL_clipboard.c \
       SDL/idris_SDL_bits.c \
       SDL/idris_SDL_gamecontroller.c \
       SDL/idris_SDL_surface.c

OBJS = $(SRCS:.c=.o)

all: $(OBJS)
	~/.cabal/bin/idris --ibcsubdir dist driver.idr -o driver && ./driver

.c.o:
	$(CC) $(CFLAGS) -c $< $(LIBS)

clean:
	rm -rf driver *~ *.ibc *.o