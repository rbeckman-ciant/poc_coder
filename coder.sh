#!/bin/bash

# Identifique a raiz do repositório do projeto
REPO_ROOT=$(pwd)

# Peça ao usuário informar a url do clone do arquivo e a senha do ssh para execução do git
read -p "Informe a URL do repositório git para clonar: " GIT_URL
read -sp "Informe a senha do SSH: " SSH_PASSWORD
echo
read -p "Informe o diretório destino para a cópia: " DEST_DIR
echo

# Verifique se o diretório existe, se não, crie-o
if [ ! -d "$REPO_ROOT/$DEST_DIR" ]; then
    mkdir -p "$REPO_ROOT/$DEST_DIR"
fi

# Inicializa o coder se ainda não existe
cd "$REPO_ROOT/$DEST_DIR" 
coder init

# Clone o repositório uma pasta acima
cd ..
echo $SSH_PASSWORD | git clone $GIT_URL cloned_repo

# Verifica se o clone foi bem-sucedido
if [ $? -ne 0 ]; then
    echo "Erro ao clonar o repositório. Encerrando."
    exit 1
fi

cd cloned_repo

# Copie todas as pastas na raiz do repositório clonado para o diretório de destino especificado
cp -fR .coder/* "$REPO_ROOT/$DEST_DIR/.coder"

# Remova a pasta do repositório que foi clonado
cd ..
rm -rf cloned_repo

echo "Processo concluído com sucesso. Arquivos copiados para $REPO_ROOT/$DEST_DIR"