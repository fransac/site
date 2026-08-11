include config.mk

OUTS = index.html \
       la-tela-di-penelope/index.html \

PUBLICOUTS = la-tela-di-penelope/music \

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
	cat header.html > $@
	$(MD2HTML) $(MD2HTMLFLAGS) $(@:.html=.md) >> $@
	cat footer.html >> $@
