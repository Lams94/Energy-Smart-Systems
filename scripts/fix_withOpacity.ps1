# Script PowerShell pour corriger les erreurs withOpacity deprecated
# Remplace withOpacity par withValues

Write-Host "🔧 Correction des erreurs withOpacity deprecated..." -ForegroundColor Green

# Fonction pour remplacer withOpacity dans un fichier
function Fix-WithOpacity {
    param([string]$FilePath)
    
    if (Test-Path $FilePath) {
        Write-Host "📝 Traitement de $FilePath..." -ForegroundColor Yellow
        
        # Lire le contenu du fichier
        $content = Get-Content $FilePath -Raw
        
        # Remplacer .withOpacity(0.x) par .withValues(alpha: 0.x)
        $content = $content -replace '\.withOpacity\(([^)]*)\)', '.withValues(alpha: $1)'
        
        # Écrire le contenu modifié
        Set-Content $FilePath -Value $content -NoNewline
    }
}

# Liste des fichiers à corriger
$files = @(
    "lib\core\router\app_router.dart",
    "lib\core\theme\app_theme.dart",
    "lib\presentation\screens\auth\login_screen.dart",
    "lib\presentation\screens\dashboard\dashboard_screen.dart",
    "lib\presentation\screens\missions\missions_screen.dart",
    "lib\presentation\widgets\dashboard_card.dart",
    "lib\presentation\widgets\mission_card.dart"
)

# Corriger chaque fichier
foreach ($file in $files) {
    Fix-WithOpacity -FilePath $file
}

Write-Host "✅ Correction terminée ! Lancez 'flutter analyze' pour vérifier." -ForegroundColor Green

# Optionnel : Lancer l'analyse automatiquement
$response = Read-Host "Voulez-vous lancer 'flutter analyze' maintenant ? (y/n)"
if ($response -eq 'y' -or $response -eq 'Y') {
    Write-Host "🔍 Analyse en cours..." -ForegroundColor Cyan
    flutter analyze
}
