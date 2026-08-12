include config.mk

SRC = src
TEMPLATE = template

OUTS = index.html \
       la-tela-di-penelope/index.html \

PUBLICOUTS = fonts \
             la-tela-di-penelope/music \
             stylesheets \

.PHONY: all clean install uninstall

all: $(OUTS)

clean:
	for o in $(OUTS); \
	do \
		rm -f "$(SRC)/$$o"; \
	done

install: all
	for o in $(OUTS) $(PUBLICOUTS); \
	do \
		mkdir -p $$(dirname "$(DESTDIR)$(ROOT)/$$o"); \
		cp -rf "$(SRC)/$$o" "$(DESTDIR)$(ROOT)/$$o"; \
	done

uninstall:
	for o in $(OUTS) $(PUBLICOUTS); \
	do \
		rm -rf "$(DESTDIR)$(ROOT)/$$o"; \
	done

$(OUTS):
	cat $(TEMPLATE)/header.html > $(SRC)/$@
	$(MD2HTML) $(MD2HTMLFLAGS) $(SRC)/$(@:.html=.md) >> $(SRC)/$@
	cat $(TEMPLATE)/footer.html >> $(SRC)/$@
