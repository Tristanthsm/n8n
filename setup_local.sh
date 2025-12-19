#!/bin/bash

echo "🚀 Configuration de l'environnement local n8n..."

# 1. Check and Install pnpm
if ! command -v pnpm &> /dev/null; then
    echo "❌ pnpm n'est pas installé."
    echo "📦 Tentative d'installation de pnpm (votre mot de passe peut être demandé pour 'sudo')..."
    sudo npm install -g pnpm
    
    if [ $? -ne 0 ]; then
        echo "💥 Erreur lors de l'installation de pnpm."
        exit 1
    fi
else
    echo "✅ pnpm est déjà installé."
fi

# 2. Install Project Dependencies
echo "📥 Installation des dépendances du projet... (Cela peut prendre un moment)"
pnpm install

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Tout est prêt !"
    echo "Pour lancer le projet, exécutez la commande suivante :"
    echo "pnpm run dev"
else
    echo "💥 Une erreur est survenue lors de l'installation des dépendances."
fi
