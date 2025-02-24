# 🚀 WSL Ubuntu Automation Script

Um script PowerShell para automatizar a instalação e configuração do WSL 2 com Ubuntu, incluindo a configuração de usuário e instalação do Podman.

## 📋 Funcionalidades

- Instalação automática do WSL 2
- Instalação e configuração do Ubuntu
- Criação automática de usuário com privilégios sudo
- Instalação do Podman
- Instalação do Gzip
- Configuração do ambiente para containers

## 🔧 Pré-requisitos

- Windows 10 versão 2004 ou superior / Windows 11
- Privilégios de administrador
- PowerShell 5.1 ou superior

## 💻 Como usar

1. Clone este repositório:
```powershell
git clone https://github.com/ThiagoEd/WSL-Ubuntu-Automation-Script.git
```

2. Navegue até o diretório do script:
```powershell
cd WSL-Ubuntu-Automation-Script
```

3. Ajuste as variáveis de usuário no início do script:
```powershell
$defaultUser = "seu-usuario"
$defaultPass = "sua-senha"
```

4. Execute o script como administrador no PowerShell:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install-wsl.ps1
```

## 🔄 O que o script faz

1. Habilita os recursos necessários do WSL
2. Instala e configura o WSL 2
3. Instala o Ubuntu
4. Cria e configura um usuário padrão
5. Instala o Podman
6. Configura o ambiente para containers

## ⚠️ Notas importantes

- O computador será reiniciado durante o processo
- Todas as senhas devem ser alteradas após a instalação
- O script deve ser executado com privilégios de administrador
- Certifique-se de ter uma conexão estável com a internet

## 🛡️ Segurança

- Altere as senhas padrão após a instalação
- Revise o script antes de executar
- Mantenha seu sistema atualizado

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer um fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abrir um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📬 Contato

Thiago Edmundo - [thiagohredmundo@gmail.com](mailto:thiagohredmundo@gmail.com)

Link do projeto: [https://github.com/ThiagoEd/WSL-Ubuntu-Automation-Script](https://github.com/ThiagoEd/WSL-Ubuntu-Automation-Script)
