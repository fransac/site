include config.mk

OUTS = index.html

.PHONY: all clean

all: $(OUTS)

clean:
	rm -f $(OUTS)

$(OUTS):
	$(MD2HTML) $(MD2HTMLFLAGS) $(@:.html=.md) > $@
