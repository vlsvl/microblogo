#Helpers
DOC_COMP = docker-compose


##
##Environment
##-------------
start: ## Start app environment
	$(DOC_COMP) up -d --remove-orphans --no-recreate
build: ## Build app environment and start 
	$(DOC_COMP) up -d --build
stop: ## Stop app environment
	$(DOC_COMP) down

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help