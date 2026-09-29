# servermine

Ambiente de **desenvolvimento e testes** de um servidor Minecraft Paper inspirado no tutorial do MaellDev:
"The BEST Way to Host a Minecraft Server! (Free and 24/7) - Updated Method".

> **Importante:** GitHub Codespaces é destinado a desenvolvimento e testes. Este repositório não inclui mecanismos para manter um Codespace artificialmente ativo, burlar timeout, cotas ou transformar Codespaces em hospedagem 24/7.

## Abrir no Codespaces

1. No GitHub, abra este repositório.
2. Clique em **Code > Codespaces > Create codespace on main**.
3. Aguarde o ambiente terminar de preparar.
4. No terminal, execute:

```bash
chmod +x setup.sh start.sh
./setup.sh
./start.sh
```

Na primeira execução, o Minecraft cria o arquivo `eula.txt` e encerra. Leia a EULA da Mojang/Minecraft. Se você concordar, altere:

```text
eula=false
```

para:

```text
eula=true
```

Depois execute novamente:

```bash
./start.sh
```

## Versão padrão

Para combinar com o Java 17 usado no tutorial, o script usa **Minecraft 1.20.1** por padrão.

Para selecionar outra versão do Paper:

```bash
MC_VERSION=1.21.11 ./setup.sh
```

A versão escolhida também precisa ser compatível com a versão do Java instalada no ambiente. Versões atuais do Paper podem exigir Java mais novo que o Java 17 mostrado no vídeo.

## Memória

O tutorial usa 1 GB. O padrão deste repositório também é 1 GB:

```bash
./start.sh
```

Para testar com outra quantidade:

```bash
RAM=2G ./start.sh
```

## Arquivos importantes

- `setup.sh`: instala dependências e baixa o build estável do Paper.
- `start.sh`: inicia o servidor com `nogui`.
- `.devcontainer/devcontainer.json`: prepara o ambiente Codespaces e registra a porta padrão 25565.
- `.gitignore`: evita enviar mundos, logs, JARs e arquivos temporários para o GitHub.

## Limitações do Codespaces

O Codespace pode parar por inatividade e o uso de computação/armazenamento conta para a cota da conta. Use este projeto para aprender, desenvolver e testar a configuração do servidor. Para um servidor realmente persistente, use uma solução de hospedagem apropriada em vez de tentar contornar os limites do Codespaces.
