
build:
	@./scripts/manage-infra/start.sh

d-build:
	@./scripts/manage-infra/stop.sh

install:
	@sudo apt update && sudo apt install curl
	@for f in ./scripts/installation/*.sh; do \
		sudo bash "$$f"; \
	done && \
	echo "============ TOOLS INSTALLED ============="; \
	kubectl version --client && \
	docker --version && \
	k3d --version && \
	argocd version --client --short && \
	echo "== ✅ Everything was successfully installed -> consider reboot to apply group changes ✅ =="

d-install:
	@./scripts/DESTROY.sh
