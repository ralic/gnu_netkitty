# NetKitty: Generic Multi Server
# Copyright (c) 2006, 2007, 2008, 2009, 2010, 2013, 2016
# 	        David Martínez Oliveira
# This file is part of NetKitty
#
# NetKitty is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# NetKitty is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with NetKitty.  If not, see <http://www.gnu.org/licenses/>.
#

DIET_CFLAGS=-falign-functions=0 -fdata-sections -ffunction-sections -Wl,--gc-sections -Os -fno-stack-protector 
DIET_LIBS=-lcompat
CFLAGS=-falign-functions=0 -fdata-sections -ffunction-sections -Wl,--gc-sections -Os -fno-stack-protector

prefix = /usr/local
bindir = $(prefix)/bin
sharedir = $(prefix)/share
mandir = $(sharedir)/man
man1dir = $(mandir)/man1


all: nk

nk: nk.c
	gcc ${CFLAGS} -o $@ $<
	strip -s $@

.PHONY:
small: nk.c
	diet -Os gcc ${DIET_CFLAGS} -o nk-diet nk.c ${DIET_LIBS}
	strip -s nk-diet

install: all
	install nk $(DESTDIR)$(bindir)
	install -m 0644 nk.1.gz $(DESTDIR)$(man1dir)
	
clean:
	rm -f nk nk-diet

debian:
	dpkg-buildpackage
