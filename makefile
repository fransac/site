include config.mk

ASSETS = assets
SRC = src
TEMPLATE = template
ICONS = assets/icon/8.png \
        assets/icon/16.png \
        assets/icon/24.png \
        assets/icon/32.png \
        assets/icon/48.png \
        assets/icon/64.png \
        assets/icon/128.png \
        assets/icon/256.png \
        assets/icon/512.png \

OUTS = 404.html \
       index.html \
       la-tela-di-penelope/index.html \

.PHONY: all clean install uninstall

all: $(OUTS)

clean:
	for o in $(OUTS); \
	do \
		rm -f "$(SRC)/$$o"; \
	done

install: all
	for o in $(OUTS); \
	do \
		mkdir -p $$(dirname "$(DESTDIR)$(ROOT)/$$o"); \
		cp -rf "$(SRC)/$$o" "$(DESTDIR)$(ROOT)/$$o"; \
	done

	mkdir -p $$(dirname $(DESTDIR)$(ROOT)/$(ASSETS))
	cp -rf $(ASSETS) $(DESTDIR)$(ROOT)/$(ASSETS)

	$(MAGICK) $(ICONS) $(DESTDIR)$(ROOT)/favicon.ico

uninstall:
	for o in $(OUTS); \
	do \
		rm -rf "$(DESTDIR)$(ROOT)/$$o"; \
	done

	rm -rf $(DESTDIR)$(ROOT)/$(ASSETS)
	rm -f $(DESTDIR)$(ROOT)/favicon.ico

$(OUTS):
	cat $(TEMPLATE)/header.html > $(SRC)/$@
	$(MD2HTML) $(MD2HTMLFLAGS) $(SRC)/$(@:.html=.md) >> $(SRC)/$@
	cat $(TEMPLATE)/footer.html >> $(SRC)/$@
