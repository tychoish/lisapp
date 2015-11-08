QLPATH := .quicklisp

NAME := $(notdir $(shell pwd))
SBCLARGS := --non-interactive --no-userinit --no-sysinit
QLSETUP := $(QLPATH)/setup.lisp
QLINSTALLER := $(QLPATH)/quicklisp.lisp
LOADQL :=  --load $(QLSETUP)


dependencies := $(shell tr "\n" " " < quicklisp-dependencies.txt)
$(QLPATH)/local-projects/$(NAME):
	rm -f $@
	ln -s `pwd`/src $@

quicklisp-manifest.txt:$(QLPATH)/local-projects/$(NAME) quicklisp-dependencies.txt
	sbcl $(SBCLARGS) $(LOADQL) $(patsubst %,--eval '(ql:quickload "%")',$(dependencies)) --eval '(ql:quickload "$(NAME)")'
	sbcl $(SBCLARGS) $(LOADQL) --eval '(ql:write-asdf-manifest-file "$@")'

build:quicklisp-manifest.txt
	buildapp --compress-core --load-path src --manifest-file $< $(patsubst %,--load-system %,$(dependencies)) --load-system $(NAME) --entry "$(NAME):main" --output $(NAME)
$(NAME):build

# setup chain for installing local quicklisp enviornment
$(QLPATH):
	mkdir -p $@
$(QLINSTALLER):$(QLPATH)
	curl "https://beta.quicklisp.org/quicklisp.lisp" > $@
$(QLSETUP):$(QLPATH)/quicklisp.lisp
	sbcl $(SBCLARGS) --load $(QLINSTALLER) --eval '(quicklisp-quickstart:install :path "$(QLPATH)")'
quicklisp ql:$(QLSETUP)

create:qucklisp
	test -d src || sbcl $(SBCLARGS) $(LOADQL) --eval '(ql:quickload "quickproject")' --eval '(quickproject:make-project #p"$(shell pwd)" :name "$(NAME)")'
	test -f .gitignore || echo "quicklisp-manifest.txt\n$(NAME)\n$(QLPATH)\n" > .gitignore
