.DEFAULT_GOAL := create

pre:
	@kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.3/config/manifests/metallb-native.yaml
	@kubectl wait --namespace metallb-system \
		--for=condition=ready pod \
		--selector=app=metallb \
		--timeout=300s
	@kubectl apply -f manifests/

helm:
	@helmfile apply

create:
	@kind create cluster --config config.yaml

up: create pre helm

destroy:
	@kind delete clusters kind

passwd:
	@echo "=== CREDENCIAIS DOS SERVIÇOS ==="
	@echo ""
	@echo "JENKINS:"
	@echo "  Usuário: admin"
	@echo -n "  Senha: "
	@kubectl get secret -n jenkins jenkins -ojson 2>/dev/null | jq -r '.data."jenkins-admin-password"' | base64 -d 2>/dev/null || echo "(Jenkins não está instalado)"
	@echo ""
	@echo ""
	@echo "ARGOCD:"
	@echo "  Usuário: admin"
	@echo -n "  Senha: "
	@kubectl get secret -n argocd argocd-initial-admin-secret -ojson 2>/dev/null | jq -r '.data.password' | base64 -d 2>/dev/null || echo "(ArgoCD não está instalado)"
	@echo ""
	@echo ""
	@echo "GITEA, SONARQUBE, HARBOR:"
	@echo "  As credenciais estão definidas nos arquivos values/"
	@echo "  Consulte: values/gitea/values.yaml"
	@echo "           values/sonarqube/values.yaml"
	@echo "           values/harbor/values.yaml"
	@echo ""