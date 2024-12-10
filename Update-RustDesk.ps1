# Скрипт для автоматического обновления RustDesk

# Укажите путь к текущей установке RustDesk (если известно)
$rustDeskPath = "${env:ProgramFiles}\RustDesk\RustDesk.exe"

# Проверяем, установлен ли RustDesk
if (-Not (Test-Path $rustDeskPath)) {
    Write-Host "RustDesk не найден. Убедитесь, что он установлен." -ForegroundColor Red
    exit 1
}

# Получаем текущую версию RustDesk
$currentVersion = (Get-Item $rustDeskPath).VersionInfo.FileVersion
Write-Host "Текущая версия RustDesk: $currentVersion" -ForegroundColor Green

# URL для загрузки последней версии RustDesk
$latestReleaseUrl = "https://api.github.com/repos/rustdesk/rustdesk/releases/latest"

# Получаем информацию о последнем релизе
try {
    $latestRelease = Invoke-RestMethod -Uri $latestReleaseUrl -Method Get
} catch {
    Write-Host "Не удалось получить информацию о последнем релизе. Проверьте подключение к интернету." -ForegroundColor Red
    exit 1
}

# Получаем версию последнего релиза
$latestVersion = $latestRelease.tag_name.TrimStart("v")
Write-Host "Последняя версия RustDesk: $latestVersion" -ForegroundColor Green

# Сравниваем версии
if ($currentVersion -eq $latestVersion) {
    Write-Host "У вас уже установлена последняя версия RustDesk." -ForegroundColor Yellow
    exit 0
}

# Находим ссылку на установщик для Windows
$downloadUrl = $latestRelease.assets | Where-Object { $_.name -like "rustdesk-*.exe" } | Select-Object -First 1 -ExpandProperty browser_download_url

if (-Not $downloadUrl) {
    Write-Host "Не удалось найти ссылку на установщик для Windows." -ForegroundColor Red
    exit 1
}

# Путь для сохранения установщика
$installerPath = "$env:TEMP\rustdesk_installer.exe"

# Загружаем установщик
Write-Host "Загрузка последней версии RustDesk..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath

# Проверяем, успешно ли загружен установщик
if (-Not (Test-Path $installerPath)) {
    Write-Host "Не удалось загрузить установщик." -ForegroundColor Red
    exit 1
}

# Устанавливаем новую версию
Write-Host "Установка новой версии RustDesk..." -ForegroundColor Cyan
Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

# Удаляем установщик после завершения
Remove-Item $installerPath -Force

Write-Host "RustDesk успешно обновлён до версии $latestVersion." -ForegroundColor Green
