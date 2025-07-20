#!/bin/bash

# Script pour corriger les erreurs withOpacity deprecated
# Remplace withOpacity par withValues

echo "🔧 Correction des erreurs withOpacity deprecated..."

# Fonction pour remplacer withOpacity dans un fichier
fix_withOpacity() {
    local file="$1"
    if [ -f "$file" ]; then
        echo "📝 Traitement de $file..."
        # Remplace .withOpacity(0.x) par .withValues(alpha: 0.x)
        sed -i 's/\.withOpacity(\([^)]*\))/.withValues(alpha: \1)/g' "$file"
    fi
}

# Liste des fichiers à corriger
files=(
    "lib/core/router/app_router.dart"
    "lib/core/theme/app_theme.dart"
    "lib/presentation/screens/auth/login_screen.dart"
    "lib/presentation/screens/dashboard/dashboard_screen.dart"
    "lib/presentation/screens/missions/missions_screen.dart"
    "lib/presentation/widgets/dashboard_card.dart"
    "lib/presentation/widgets/mission_card.dart"
)

# Corriger chaque fichier
for file in "${files[@]}"; do
    fix_withOpacity "$file"
done

echo "✅ Correction terminée ! Lancez 'flutter analyze' pour vérifier."
