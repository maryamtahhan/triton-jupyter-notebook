# SPDX-License-Identifier: BSD-3-Clause
# Copyright (c) 2024 Red Hat Inc

##@ Help

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk commands is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


mkfile_path=$(abspath $(lastword $(MAKEFILE_LIST)))
source_dir=$(shell dirname "$(mkfile_path)")
USERNAME=$(shell echo $(USER) | tr A-Z a-z)
NPROC=$(shell nproc)
export CTR_CMD?=$(or $(shell command -v podman), $(shell command -v docker))

##@ Container build.
image-builder-check:
	@if [ -z '$(CTR_CMD)' ] ; then echo '!! ERROR: containerized builds require podman||docker CLI, none found $$PATH' >&2 && exit 1; fi

all: triton-image triton-cpu-image

triton-image: image-builder-check
	$(CTR_CMD) build -t triton-jupyter --build-arg USERNAME=${USER} \
 --build-arg NPROC=${NPROC} -f Dockerfile.triton .

triton-cpu-image: image-builder-check
	$(CTR_CMD) build -t triton-cpu-jupyter --build-arg USERNAME=${USER} \
 --build-arg NPROC=${NPROC} -f Dockerfile.triton-cpu .

triton-run: image-builder-check
	$(CTR_CMD) run --runtime=nvidia --gpus=all -p 8888:8888 -v ${source_dir}/notebooks:/notebooks triton-jupyter

triton-cpu-run: image-builder-check
	$(CTR_CMD) run -p 8888:8888 -v ${source_dir}/notebooks:/notebooks triton-jupyter

