# 🔧 Configuração Inicial

Este guia explica como configurar o projeto para o seu ambiente.

## 1. Substituir Placeholders

Antes de usar o projeto, você precisa substituir os placeholders pelos seus valores reais:

### Placeholders a substituir:

- `<YOUR_HARBOR_PROJECT>` - Nome do seu projeto no Harbor Registry
- `<YOUR_GIT_SERVER>` - Seu servidor Git (ex: github.com, gitlab.com)
- `<YOUR_USER>` - Seu usuário Git
- `<YOUR_GIT_REPO_URL>` - URL do seu repositório Git
- `<YOUR_SHARED_LIBRARY_REPO>` - URL do repositório de shared libraries do Jenkins

### Arquivos que contêm placeholders:

```bash
# Encontrar todos os placeholders
grep -r "<YOUR_" . --exclude-dir={.git,venv,node_modules}
```

### Substituição em massa (opcional):

```bash
# Substituir HARBOR_PROJECT
find . -type f \( -name "*.groovy" -o -name "*.yaml" -o -name "*.yml" \) \
  -not -path "./venv/*" -not -path "./.git/*" \
  -exec sed -i 's/<YOUR_HARBOR_PROJECT>/seu-projeto/g' {} \;

# Substituir GIT_SERVER
find . -type f \( -name "*.groovy" -o -name "*.yaml" -o -name "*.yml" \) \
  -not -path "./venv/*" -not -path "./.git/*" \
  -exec sed -i 's/<YOUR_GIT_SERVER>/github.com/g' {} \;
```

## 2. Configurar Credenciais

### Jenkins

Após instalar o Jenkins, configure as credenciais:

1. Acesse: http://jenkins.localhost.com
2. Vá em: Manage Jenkins → Credentials
3. Adicione:
   - **Git Credentials** (SSH ou Username/Password)
   - **Harbor Credentials** (Username/Password)

### Harbor

1. Acesse: http://harbor.localhost.com
2. Crie um projeto com o nome que você definiu em `<YOUR_HARBOR_PROJECT>`
3. Crie um usuário robot para o Jenkins

### Gitea (Opcional)

Se você estiver usando Gitea local:

1. Acesse: http://gitea.localhost.com
2. Crie uma organização/usuário
3. Crie os repositórios necessários
4. Configure SSH keys

## 3. Atualizar Values do Helm

Edite os arquivos em `values/` para configurar senhas e outras configurações:

```bash
# Gitea
vim values/gitea/values.yaml

# Harbor
vim values/harbor/values.yaml

# SonarQube
vim values/sonarqube/values.yaml
```

## 4. Instalar o Cluster

Após configurar tudo:

```bash
# Criar cluster e instalar serviços
make up

# Configurar /etc/hosts
./update-hosts.sh

# Obter credenciais
make passwd
```

## 5. Verificar Instalação

```bash
# Verificar pods
kubectl get pods --all-namespaces

# Verificar serviços
kubectl get svc --all-namespaces

# Acessar Jenkins
open http://jenkins.localhost.com
```

## 📝 Checklist

- [ ] Substituir todos os placeholders `<YOUR_*>`
- [ ] Configurar credenciais no Jenkins
- [ ] Criar projeto no Harbor
- [ ] Atualizar values do Helm com suas configurações
- [ ] Executar `make up`
- [ ] Executar `./update-hosts.sh`
- [ ] Verificar que todos os serviços estão rodando
- [ ] Testar acesso aos serviços

## 🆘 Problemas Comuns

### Placeholders ainda presentes

```bash
# Verificar se ainda há placeholders
grep -r "<YOUR_" . --exclude-dir={.git,venv}
```

### Credenciais não funcionam

- Verifique se as credenciais foram criadas no Jenkins
- Verifique se o ID da credencial no Jenkinsfile corresponde ao configurado

### Serviços não acessíveis

- Execute `./update-hosts.sh` novamente
- Verifique se o Nginx Ingress está rodando: `kubectl get pods -n ingress-nginx`
