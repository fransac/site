include config.mk

OUTS = src/index.html

.PHONY: all clean

all: $(OUTS)

clean:
	rm -f $(OUTS)

$(OUTS):
	$(MD2HTML) $(@:.html=.md) > $@
