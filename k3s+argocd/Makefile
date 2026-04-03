
build:
	@./scripts/manage-infra/start.sh

d-build:
	@./scripts/manage-infra/stop.sh

install:
	@for f in ./scripts/installation/*.sh; do \
		sudo bash "$$f"; \
	done && \
	echo "============ TOOLS INSTALLED ============="; \
	kubectl version --client && \
	docker --version && \
	k3d --version && \
	argocd version --client --short && \
	echo "== ✅ EVERYTHING WAS SUCCESSFULLY INSTALLED ✅ =="

d-install:
	@./scripts/DESTROY.sh
