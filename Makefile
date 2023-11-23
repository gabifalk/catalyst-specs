TIMESTAMP = $(shell TZ=UTC date +%Y%m%d)
SNAPSHOT = $(shell GIT_DIR=/var/tmp/catalyst/repos/gentoo.git git log --format=%H)

%: %.in
	sed \
		-e 's,@DIR@,$(CURDIR),g' \
		-e 's,@TIMESTAMP@,$(TIMESTAMP),g' \
		-e 's,@SNAPSHOT@,$(SNAPSHOT),g' \
		<$< >$@
	touch -r $< $@
	chmod --reference=$< $@

TARGETS = catalyst.conf stage1-test.spec stage3-test.spec stage4-test.spec

all: $(TARGETS)

clean:
	rm -f -- $(TARGETS)
