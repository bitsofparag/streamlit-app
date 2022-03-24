IMG_REPO ?= bitsofparag/streamlit-app
APPS = $(shell find . -type d -name 'app_*')

define PRINT_HELP_PYSCRIPT
import re, sys
for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

define DIST_HELP
Please provide a valid APP and VERSION.
>> APP=app_folder_name VERSION=1.2.3 make dist
endef

define _get_version
cd $1 && \
	if [[ -f setup.py ]]; then python3 setup.py --version;\
	elif [[ -f VERSION ]]; then cat VERSION;\
	elif [[ -f package.json ]]; then awk -F \" '/"version": ".+"/ { print $4; exit; }' package.json;\
	else echo "No version found" && exit 1;fi
endef


help: ## Help
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)


app_%: ## Build docker image for public registry
	VERSION=$(call _get_version, $<)
	@docker build \
		--build-arg VERSION=${VERSION} \
		-t ${IMG_REPO}:${VERSION} .


publish-versions: ## Publish versioned tag to docker registry
ifeq (${VERSION}, )
	@echo "$$DIST_HELP"
	@exit 1
endif
	@docker image push ${IMG_REPO}:${VERSION}


publish-latest: ## Publish 'latest' tag to docker registry
ifeq (${VERSION}, )
	@echo "$$DIST_HELP"
	@exit 1
endif
	@docker image tag ${IMG_REPO}:${VERSION} ${IMG_REPO}:latest
	@docker image push ${IMG_REPO}:latest


.PHONY: help dist publish-versions publish-latest
.DEFAULT: help
