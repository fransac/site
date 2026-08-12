include config.mk

ASSETS = assets
SRC = src
TEMPLATE = template

OUTS = index.html \
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

	mkdir -p $(DESTDIR)$(ROOT)
	cp -rf $(ASSETS) $(DESTDIR)$(ROOT)

uninstall:
	for o in $(OUTS); \
	do \
		rm -rf "$(DESTDIR)$(ROOT)/$$o"; \
	done

	rm -rf $(DESTDIR)$(ROOT)/$(ASSETS)

$(OUTS):
	cat $(TEMPLATE)/header.html > $(SRC)/$@
	$(MD2HTML) $(MD2HTMLFLAGS) $(SRC)/$(@:.html=.md) >> $(SRC)/$@
	cat $(TEMPLATE)/footer.html >> $(SRC)/$@
