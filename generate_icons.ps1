# Script de génération d'icônes ESS pour Android
# Génère toutes les tailles d'icônes à partir du logo principal

param(
    [string]$SourceLogo = "assets\images\logo.png"
)

Write-Host "🎨 Génération des icônes ESS pour Android" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

# Vérifier que le logo source existe
if (-not (Test-Path $SourceLogo)) {
    Write-Host "❌ Logo source non trouvé: $SourceLogo" -ForegroundColor Red
    Write-Host "💡 Placez votre logo ESS dans assets/images/logo.png" -ForegroundColor Yellow
    exit 1
}

# Définir les tailles d'icônes Android
$iconSizes = @{
    "mipmap-mdpi" = 48
    "mipmap-hdpi" = 72
    "mipmap-xhdpi" = 96
    "mipmap-xxhdpi" = 144
    "mipmap-xxxhdpi" = 192
}

$baseDir = "android\app\src\main\res"

# Fonction pour redimensionner avec ImageMagick (si disponible)
function Resize-WithImageMagick($source, $output, $size) {
    try {
        magick convert "$source" -resize "${size}x${size}" "$output"
        return $true
    } catch {
        return $false
    }
}

# Fonction pour copier le logo (fallback)
function Copy-Logo($source, $output) {
    Copy-Item $source $output -Force
    Write-Host "📋 Copié (taille originale): $output" -ForegroundColor Yellow
}

Write-Host "🔄 Génération des icônes..." -ForegroundColor Yellow

$hasImageMagick = $false
try {
    magick -version | Out-Null
    $hasImageMagick = $true
    Write-Host "✅ ImageMagick détecté - redimensionnement automatique" -ForegroundColor Green
} catch {
    Write-Host "⚠️  ImageMagick non disponible - copie du logo original" -ForegroundColor Yellow
}

foreach ($dir in $iconSizes.Keys) {
    $size = $iconSizes[$dir]
    $targetDir = Join-Path $baseDir $dir
    $targetFile = Join-Path $targetDir "ic_launcher.png"
    
    # Créer le répertoire s'il n'existe pas
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }
    
    if ($hasImageMagick) {
        if (Resize-WithImageMagick $SourceLogo $targetFile $size) {
            Write-Host "✅ Généré ${size}x${size}: $targetFile" -ForegroundColor Green
        } else {
            Copy-Logo $SourceLogo $targetFile
        }
    } else {
        Copy-Logo $SourceLogo $targetFile
    }
}

# Créer aussi l'icône adaptative (Android 8+)
$adaptiveDir = Join-Path $baseDir "mipmap-anydpi-v26"
if (-not (Test-Path $adaptiveDir)) {
    New-Item -ItemType Directory -Path $adaptiveDir -Force | Out-Null
}

# Icône adaptative avec logo ESS
$adaptiveXml = @'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ess_background"/>
    <foreground android:drawable="@drawable/app_logo"/>
</adaptive-icon>
'@

$adaptiveFile = Join-Path $adaptiveDir "ic_launcher.xml"
$adaptiveXml | Out-File -FilePath $adaptiveFile -Encoding UTF8

Write-Host "✅ Icône adaptative créée: $adaptiveFile" -ForegroundColor Green

Write-Host ""
Write-Host "🎯 Génération terminée !" -ForegroundColor Green
Write-Host "💡 Conseils:" -ForegroundColor Cyan
Write-Host "   • Installez ImageMagick pour le redimensionnement automatique" -ForegroundColor White
Write-Host "   • Votre logo ESS est maintenant l'icône de l'application" -ForegroundColor White
Write-Host "   • Rebuild et réinstallez l'APK pour voir les changements" -ForegroundColor White
Write-Host ""
