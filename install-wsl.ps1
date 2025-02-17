### INSTALAÇÃO AUTOMÁTICA DO WSL COM UBUNTU ###

# Defina as variáveis com o nome de usuário e senha desejados
$defaultUser = "meuusuario"
$defaultPass = "minhasenha"

Write-Host "### INSTALAÇÃO AUTOMÁTICA DO WSL COM UBUNTU ###" -ForegroundColor Green

# Verificar se está executando como administrador
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Por favor, execute como Administrador!"
    Break
}

# Habilitar WSL
Write-Host "`nHabilitando o WSL..." -ForegroundColor Cyan
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Habilitar Plataforma de Máquina Virtual
Write-Host "`nHabilitando o recurso de Máquina Virtual..." -ForegroundColor Cyan
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Baixar e instalar o pacote de atualização do kernel do WSL 2
Write-Host "`nBaixando o pacote de atualização do WSL..." -ForegroundColor Cyan
$wslUpdateUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$wslUpdateFile = "$env:TEMP\wsl_update_x64.msi"

try {
    Invoke-WebRequest -Uri $wslUpdateUrl -OutFile $wslUpdateFile
    Write-Host "Download concluído. Instalando o pacote..." -ForegroundColor Cyan
    Start-Process msiexec.exe -Wait -ArgumentList "/I $wslUpdateFile /quiet"
    Remove-Item $wslUpdateFile
} catch {
    Write-Warning "Erro ao baixar ou instalar o pacote de atualização: $_"
    Break
}

# Definir WSL 2 como versão padrão
Write-Host "`nDefinindo WSL 2 como versão padrão..." -ForegroundColor Cyan
wsl --set-default-version 2

# Instalar Ubuntu
Write-Host "`nInstalando Ubuntu..." -ForegroundColor Cyan
try {
    # Instalando Ubuntu via winget
    Write-Host "Instalando Ubuntu via Windows Store..." -ForegroundColor Cyan
    wsl --install -d Ubuntu

    # Aguardando a instalação
    Write-Host "Aguardando a instalação do Ubuntu..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10

    # Verificando se Ubuntu foi instalado
    $ubuntuInstalled = wsl -l | Select-String "Ubuntu"
    if ($ubuntuInstalled) {
        Write-Host "Ubuntu instalado com sucesso!" -ForegroundColor Green
    } else {
        Write-Warning "Ubuntu pode não ter sido instalado corretamente. Por favor, verifique."
    }
} catch {
    Write-Warning "Erro ao instalar Ubuntu: $_"
}

Write-Host "`nInstalação concluída!" -ForegroundColor Green
Write-Host "Para completar a instalação, reinicie o computador." -ForegroundColor Yellow
Write-Host "Na primeira execução do Ubuntu, você precisará criar um nome de usuário e senha." -ForegroundColor Yellow
Write-Host "Deseja reiniciar o computador agora? (S/N)" -ForegroundColor Yellow
$resposta = Read-Host

if ($resposta -eq 'S' -or $resposta -eq 's') {
    Restart-Computer
} else {
    Write-Host "`nLembre-se de reiniciar o computador mais tarde para completar a instalação." -ForegroundColor Yellow
}

# Aguardando 10 segundos para garantir a instalação do ubuntu
Start-Sleep -Seconds 10

Write-Host "`nConfigurando usuário padrão no Ubuntu..." -ForegroundColor Cyan

# Criar usuário e senha no Ubuntu 

wsl -d Ubuntu -u root -- bash -c "useradd -m -s /bin/bash $defaultUser"
wsl -d Ubuntu -u root -- bash -c "echo '$defaultUser':'$defaultPass' | chpasswd"
wsl -d Ubuntu -u root -- bash -c "usermod -aG sudo $defaultUser"
wsl -d Ubuntu -u root -- bash -c "echo -e '[user]\ndefault=$defaultUser' > /etc/wsl.conf"

Write-Host "Usuário '$defaultUser' criado e configurado como padrão no Ubuntu WSL." -ForegroundColor Green

# Instalar o Podman e criar Container MongoDB

wsl -d Ubuntu -u root -- bash -c "sudo apt update && sudo apt upgrade"
wsl -d Ubuntu -u root -- bash -c "sudo update-alternatives --set iptables /usr/sbin/iptables-legacy"
wsl -d Ubuntu -u root -- bash -c "sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy"
wsl -d Ubuntu -u root -- bash -c "sudo apt install podman -y"
wsl -d Ubuntu -u root -- bash -c "podman run -d --name mongo -p 27017:27017 docker.io/mongo:latest"


