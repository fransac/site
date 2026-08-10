include config.mk

OUTS = index.html

.PHONY: all clean install uninstall

all: $(OUTS)

clean:
	rm -f $(OUTS)

install: all
	for o in $(OUTS); \
	do \
		mkdir -p $$(dirname "$(DESTDIR)$(ROOT)/$$o"); \
		cp -f "$$o" "$(DESTDIR)$(ROOT)/$$o"; \
	done

uninstall:
	for o in $(OUTS); \
	do \
		rm -f "$(DESTDIR)$(ROOT)/$$o"; \
	done

$(OUTS):
	$(MD2HTML) $(MD2HTMLFLAGS) $(@:.html=.md) > $@
