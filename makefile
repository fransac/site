include config.mk

OUTS = index.html \
       la-tela-di-penelope/index.html \

PUBLICOUTS = fonts \
             la-tela-di-penelope/music \
             stylesheets \

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
	cat template/header.html > $@
	$(MD2HTML) $(MD2HTMLFLAGS) $(@:.html=.md) >> $@
	cat template/footer.html >> $@
