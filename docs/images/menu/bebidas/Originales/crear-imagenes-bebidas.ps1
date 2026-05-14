$basePath = "C:\Users\uniyo\OneDrive\Documentos\PASAR A DISCO\GitHub\zafiro\public\images\menu\bebidas"

$files = @(
    "poker.jpg",
    "aguila-original.jpg",
    "corona.jpg",
    "coronita.jpg",
    "club-colombia.jpg",
    "budweiser.jpg",
    "costena.jpg",
    "smirnoff-ice-personal.jpg",
    "stella-artois.jpg",
    "coca-cola.jpg",
    "agua-cristal.jpg",
    "agua-con-gas.jpg",
    "canada-dry.jpg",
    "sprite.jpg",
    "jugo-hit-surtido.jpg",
    "gaseosa-surtida-postobon.jpg",
    "speed-max.jpg",
    "squash-personal.jpg",
    "bretana-soda.jpg",
    "aguardiente-negro-verde.jpg",
    "aguardiente-azul.jpg",
    "aguardiente-amarillo.jpg",
    "ron-viejo-de-caldas.jpg",
    "old-parr.jpg",
    "buchanans-deluxe.jpg",
    "buchanans-master.jpg",
    "grants.jpg",
    "don-julio-blanco.jpg"
)

if (-not (Test-Path $basePath)) {
    New-Item -ItemType Directory -Path $basePath -Force | Out-Null
}

foreach ($file in $files) {
    $fullPath = Join-Path $basePath $file

    if (-not (Test-Path $fullPath)) {
        New-Item -ItemType File -Path $fullPath | Out-Null
        Write-Host "Creado: $fullPath"
    }
    else {
        Write-Host "Ya existe: $fullPath"
    }
}

Write-Host ""
Write-Host "Proceso terminado."