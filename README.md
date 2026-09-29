# servermine

Servidor de **Minecraft Java 26.2 + Fabric** preparado para desenvolvimento/testes em GitHub Codespaces, com suporte ao agente **playit.gg** para criar um túnel até a porta local do servidor.

> GitHub Codespaces é um ambiente de desenvolvimento/testes e pode parar por inatividade ou por limites de cota. Os scripts deste repositório não tentam burlar esses limites.

## Configuração usada

- Minecraft Java: **26.2**
- Fabric Loader: **0.19.3**
- Fabric Installer/Launcher: **1.1.2**
- Java: **25**
- Porta Minecraft: **25565**
- RAM padrão: **2 GB**
- Túnel: **playit.gg agent**

## 1. Criar o Codespace

No GitHub:

1. Abra este repositório.
2. Clique em **Code**.
3. Abra **Codespaces**.
4. Clique em **Create codespace on main**.

## 2. Instalar Fabric 26.2

No terminal:

```bash
./setup.sh
```

O script instala Java 25 e baixa o launcher oficial do servidor Fabric 26.2 como `server.jar`.

Depois rode:

```bash
./start.sh
```

Na primeira execução o Minecraft deverá gerar `eula.txt` e encerrar.

Leia a EULA do Minecraft. Se você concordar, altere:

```text
eula=false
```

para:

```text
eula=true
```

Depois inicie novamente:

```bash
./start.sh
```

## 3. Instalar o Playit

Em outro terminal do Codespace:

```bash
./setup-playit.sh
```

Depois vincule o agente à sua conta:

```bash
playit setup
```

O comando exibirá uma URL de claim/autorização. Abra essa URL no navegador e autorize o agente na sua conta do playit.gg.

Não coloque códigos, chaves ou segredos do Playit neste repositório.

## 4. Criar o túnel Minecraft Java

Depois de vincular o agente, no painel do Playit crie um túnel usando o preset **Minecraft Java** e selecione o agente deste Codespace.

Configure a origem/local do túnel para:

```text
Local IP: 127.0.0.1
Local Port: 25565
```

O Playit fornecerá um endereço público para seus jogadores usarem.

## 5. Rodar Playit + Minecraft

Depois que o agente já estiver vinculado:

```bash
./start-all.sh
```

Esse script inicia o agente Playit em segundo plano e, em seguida, inicia o servidor Fabric.

Os logs do agente ficam em:

```text
playit.log
```

Para iniciar somente o Minecraft:

```bash
./start.sh
```

Para iniciar somente o Playit:

```bash
./start-playit.sh
```

## RAM

Padrão:

```bash
./start.sh
```

Usar 4 GB:

```bash
RAM=4G ./start.sh
```

Com Playit:

```bash
RAM=4G ./start-all.sh
```

## Mods

Depois da primeira inicialização, coloque mods compatíveis com **Minecraft 26.2 + Fabric** na pasta:

```text
mods/
```

Muitos mods também exigem Fabric API.

## Arquivos

- `setup.sh`: instala Java 25 e baixa Fabric Server 26.2.
- `start.sh`: inicia o Fabric.
- `setup-playit.sh`: instala o agente oficial do Playit.
- `start-playit.sh`: executa somente o agente Playit.
- `start-all.sh`: executa Playit e Minecraft juntos.
- `.devcontainer/devcontainer.json`: configuração do Codespace.
