include config.mk

OUTS = index.html

PUBLICOUTS =

.PHONY: all clean install uninstall

all: $(OUTS)

clean:
	rm -f $(OUTS)

install: all
	for o in $(OUTS) $(PUBLICOUTS); \
	do \
		mkdir -p $$(dirname "$(DESTDIR)$(ROOT)/$$o"); \
		cp -rf "$$o" "$(DESTDIR)$(ROOT)/$$o"; \
	done

uninstall:
	for o in $(OUTS) $(PUBLICOUTS); \
	do \
		rm -rf "$(DESTDIR)$(ROOT)/$$o"; \
	done

$(OUTS):
	sed "s|@TITLE@|$$(head -n 1 $(@:.html=.md))|" header.html > $@
	$(MD2HTML) $(MD2HTMLFLAGS) $(@:.html=.md) >> $@
	cat footer.html >> $@
