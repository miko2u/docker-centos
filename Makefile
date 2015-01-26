#
NAME := miko2u
CONTAINER := centos6
VERSION := $(or $(VERSION),$(VERSION),'6.6')
HOSTNAME := $(CONTAINER)

all: build

base:
	@docker pull centos:centos6

build: base
	@docker build --rm -t $(NAME)/$(CONTAINER) .

rebuild: base
	@docker build --rm --no-cache -t $(NAME)/$(CONTAINER):$(VERSION) .

start:
	@docker create -it -h $(HOSTNAME).localdomain --name $(CONTAINER) $(NAME)/$(CONTAINER)
	@docker start $(CONTAINER)

clean:
	@docker stop $(CONTAINER)
	@docker rm $(CONTAINER)
