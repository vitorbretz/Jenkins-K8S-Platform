#!/bin/bash

# Script para atualizar /etc/hosts para usar o IP do MetalLB

echo "Atualizando /etc/hosts para usar MetalLB (172.18.0.50)..."

sudo sed -i 's/127.0.0.1 gitea.localhost.com/172.18.0.50 gitea.localhost.com/' /etc/hosts
sudo sed -i 's/127.0.0.1 jenkins.localhost.com/172.18.0.50 jenkins.localhost.com/' /etc/hosts
sudo sed -i 's/127.0.0.1 argocd.localhost.com/172.18.0.50 argocd.localhost.com/' /etc/hosts
sudo sed -i 's/127.0.0.1 sonarqube.localhost.com/172.18.0.50 sonarqube.localhost.com/' /etc/hosts
sudo sed -i 's/127.0.0.1 harbor.localhost.com/172.18.0.50 harbor.localhost.com/' /etc/hosts
sudo sed -i 's/127.0.0.1 api.localhost.com/172.18.0.50 api.localhost.com/' /etc/hosts

echo "Verificando /etc/hosts:"
grep "localhost.com" /etc/hosts

echo ""
echo "✅ Pronto! Agora você pode acessar os serviços diretamente:"
echo "  - http://jenkins.localhost.com"
echo "  - http://gitea.localhost.com"
echo "  - http://harbor.localhost.com"
echo "  - http://sonarqube.localhost.com"
echo "  - http://argocd.localhost.com"
echo ""
echo "⚠️  Não precisa mais de port-forward!"
