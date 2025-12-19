#!/bin/bash

echo "🚀 Démarrage automatique de n8n en local..."

# 1. Enable Corepack to get pnpm
if ! command -v pnpm &> /dev/null; then
    echo "📦 Activation de Corepack pour installer pnpm..."
    corepack enable || { 
        echo "🔒 Permission refusée. Tentative avec 'sudo' (votre mot de passe est requis)..."
        sudo corepack enable 
    }
fi

# 2. Install dependencies
echo "📥 Vérification et installation des dépendances..."
pnpm install

# 3. Build the project (CRITICAL FIX)
# The "Cannot find module" errors happen because the internal libraries are not built yet.
echo "🏗️  Construction du projet (cela peut prendre quelques minutes la première fois)..."
pnpm run build

if [ $? -ne 0 ]; then
    echo "💥 Erreur lors de la construction du projet."
    exit 1
fi

# 4. Launch the app (excluding playwright tests)
echo "✅ Lancement du serveur de développement..."
echo "Pour arrêter le serveur, appuyez sur CTRL+C"
echo "---------------------------------------------------"
# We exclude n8n-playwright to avoid the error you saw and because you likely just want to run the app.
pnpm run dev --filter=!n8n-playwright
