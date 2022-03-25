SHELL := bash
IMG_REPO_PREFIX ?= bitsofparag/

define PRINT_HELP_PYSCRIPT
import re, sys
for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT


help: ## Help
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)


apps: ## Build docker images for all apps
	for app in apps/* ; do \
		docker build \
			--build-arg VERSION=`cat $$app/VERSION` \
			-t ${IMG_REPO_PREFIX}`basename $$app`:`cat $$app/VERSION` $$app ; \
	done


app: ## Build docker image for user-specified $APP
ifeq (${APP}, )
	@echo "Usage: APP=app-folder-name make app"
	@exit 1
endif
	app=apps/${APP} \
	&& docker build \
			--build-arg VERSION=`cat $$app/VERSION` \
			-t ${IMG_REPO_PREFIX}`basename $$app`:`cat $$app/VERSION` $$app ; \


publish-versions: apps ## Publish versioned tag to docker registry
	@for app in apps/* ; do \
		docker image push ${IMG_REPO_PREFIX}`basename $$app`:`cat $$app/VERSION`; \
	done


publish-all: publish-versions ## Publish 'latest' tag to docker registry
	@for app in apps/* ; do \
		docker image tag ${IMG_REPO_PREFIX}`basename $$app`:`cat $$app/VERSION` ${IMG_REPO_PREFIX}`basename $$app`:latest ; \
		docker image push ${IMG_REPO_PREFIX}`basename $$app`:latest ; \
	done


lint-all: ## Lint all app Dockerfiles
	@for app in apps/* ; do \
		dockerlint $$app/Dockerfile ; \
	done


.PHONY: help app apps publish-versions publish-all lint-all
.DEFAULT: help
