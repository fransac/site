include config.mk

ASSETS = assets
SRC = src
TEMPLATE = template
FAVICON = favicon.ico

OUTS = 404.html \
       index.html \
       la-tela-di-penelope/index.html \

STATICOUTS = snake/index.html \

.PHONY: all clean install uninstall

all: $(OUTS) $(STATICOUTS)

clean:
	for o in $(OUTS) $(STATICOUTS); \
	do \
		rm -f "$(SRC)/$$o"; \
	done

install: all
	for o in $(OUTS) $(STATICOUTS); \
	do \
		mkdir -p $$(dirname "$(DESTDIR)$(ROOT)/$$o"); \
		cp -rf "$(SRC)/$$o" "$(DESTDIR)$(ROOT)/$$o"; \
	done

	mkdir -p $$(dirname $(DESTDIR)$(ROOT)/$(ASSETS))
	cp -rf $(ASSETS) $(FAVICON) $(DESTDIR)$(ROOT)

uninstall:
	for o in $(OUTS) $(STATICOUTS); \
	do \
		rm -rf "$(DESTDIR)$(ROOT)/$$o"; \
	done

	rm -rf $(DESTDIR)$(ROOT)/$(ASSETS) $(DESTDIR)$(ROOT)/$(FAVICON)

$(OUTS):
	cat $(TEMPLATE)/header.html > $(SRC)/$@
	$(MD2HTML) $(MD2HTMLFLAGS) $(SRC)/$(@:.html=.md) >> $(SRC)/$@
	cat $(TEMPLATE)/footer.html >> $(SRC)/$@

$(STATICOUTS):
	cat $(TEMPLATE)/header.html > $(SRC)/$@
	cat $(SRC)/$(@:.html=.static.html) >> $(SRC)/$@
	cat $(TEMPLATE)/footer.html >> $(SRC)/$@
