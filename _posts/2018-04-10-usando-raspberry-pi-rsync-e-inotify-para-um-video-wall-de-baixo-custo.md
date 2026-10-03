---
layout: post
title: Usando Raspberry Pi, rsync e inotify para um video wall de baixo custo
author: Maiquel Leonel
date: '2018-04-10'
tags:
- Linux
- Raspberry Pi
- Shell Script
- Hardware
description: Como construir um sistema de looping de vídeo automatizado e sincronizado
  remotamente usando Raspberry Pi, scripts em bash e monitoramento inotify.
---


Sabe aquele brinquedo que tu sempre quis brincar, desmontar e entender como funciona? Tipo o Atari que tu teves na infância? Ok, no meu caso um CCE Supergame mas né… Anos 80, portos fechados, a gente nem era tão exigente com as marcas naquela época… Enfim, sempre me senti assim com o Raspberry Pi.

O Raspberry Pi é um “miniPC” de baixíssimo custo. Tu encontras a versão mais potente dele, a Model B+, por cerca de U$40,00. Sim o “PC” completo, com processador Quad Core 1.2GHz, 4 portas USB, rede wifi e RJ-45, saída HDMI e 1GB de RAM por 40 “trumps”?! É muito barato! Lembrando que outras versões não tão atuais do PCzinho com menos processamento e RAM são ainda mais baratas! Chegando a versões de U$20,00 ou menos.

Agora tu deves estar se perguntando: “Tá! Mas o que eu farei com um Hardware tão modesto?” Bom, existe uma série de utilidades pro PCzinho. Sério são muitas mesmo! Uma olhada nesse site de projetos já te deixa envolvido por horas a fio.

Falando da distro GNU/Linux que o RaspberryPi embarca: ela é a Raspbian, uma derivada de Debian com os drivers, ambiente gráfico e outros apps escolhidos “a dedo” pra funcionar perfeitamente no PCzinho. Sou entusiasta de Debian (e derivadas) desde 2004/2005, não tive dificuldade nenhuma. Foi só escolher os softwares certos e correr pro abraço!

---

## O PROBLEMA

O projeto é bem simples: tocar videos de propaganda em loop nos “terminais” do quiosque, de maneira que os vídeos pudessem ser periodicamente atualizados. Basicamente: um “videolooper atualizável”. Depois de algumas tentativas com outras ferramentas conhecidas de “arquivos em nuvem” que não rodaram bem com o RaspberryPi, decidimos resolver de uma maneira mais “braçal” porém funcional.

---

## A SOLUÇÃO

A solução que desenhamos foi bem sucinta: um usuário sobe um video para um FTP específico, o RaspberryPi monitora esse endereço via rsync e o inotify-tools informa o sistema operacional que recebeu um novo vídeo, o S.O. por sua vez faz um reboot para que o novo video comece a tocar no video looper e tudo sincroniza automágicamente :D. Barbada né? Pois é, nem tanto.

---

## A IMPLANTAÇÃO

Depois de instalado o videolooper, precisei mexer na cron do Raspberry para agendar a execução tanto o rsync quanto do inotify. O detalhe é que, seja lá por qual motivo, a cron de usuário simplesmente não funcionou. De jeito nenhum! Nem agendando na cron do root, nem salvando do /etc/hourly.d/. O jeito foi salvar na cron do sistema mesmo. Depois ainda descobri no stackOverflow que é um “detalhe” da própria distro. Feito isso, conseguimos o comportamento esperado.

---

## AQUELE SUPER-DETALHAMENTO MAROTO

A primeira coisa a se fazer é instalar as libs rsync e inotify-tools com o apt velho de guerra. Pensei que fosse preciso configurar algum PPA mas pra minha surpresa ambos estavam no mirror do Raspbian. Então foi muito simples.

```bash
$ sudo apt install rsync inotify-tools
```

Dependências instaladas, o show pode começar. A primeira tarefa é fazer o rsync monitorar a pasta remota na pasta que o videolooper lerá. Isso eu farei por um shellscript. Crio um arquivo chamado `atualizador.sh`, dou permissão de execução com o comando `chmod +x atualizador.sh`, e adiciono o seguinte conteúdo:

Explicando detalhadamente: o que fiz foi deixar em variáveis tudo o que vamos precisar para diminuir o tamanho do comando e melhorar a legibilidade. Ficou uma variável por linha e o comando no final, façinho!

Onde:
* **RSYNC**: é o path para o binário do rsync
* **SSH**: é a path para o shell
* **KEY**: é a chave de acesso
* **RUSER**: é o usuário para conectar no servidor remoto
* **RHOST**: é o endereço do servidor remoto
* **RPATH**: é o caminho onde os vídeos serão upados periódicamente
* **LPATH**: é o caminho local onde serão salvos os vídeos

A última linha é o comando em si, as opções são as seguintes: `-r` (recursiva), `-a` (arquivamento), `-z` (compactar), `-p` (preservar permissões), `--force`, `--delete-before`, `--ignore-errors` e `-e` (usar SSH).

Feito isso, agora temos que dizer pro Raspbian que queremos consultar o servidor remoto, a cada 1h, em busca de novos videos. Fazemos isso agendando na crontab do Raspbian (`/etc/crontab`):

```bash
* */1 * * * root /home/pi/atualizador.sh
```

A solução para trocar o vídeo em exibição foi fazer reboot. Com um S.O. rodando em um SDCard, o boot não leva mais de 10 segundos.

Configurar o inotify-tools: Criei um arquivo chamado `monitor.sh` (`chmod +x monitor.sh`) para executar um reboot sempre que um arquivo no diretório `/home/pi/Videos/` for fechado para escrita.

Para iniciar no boot, adicionei ao `/etc/crontab`:

```bash
@reboot root /home/pi/monitor.sh
```

---

## PÓS INSTALAÇÃO

Para resolver o problema do rsync não deletar arquivos locais, adicionei o comando:

```bash
find /home/pi/Videos/ -type f -size 0 -delete
```

Isso remove arquivos de 0 bytes, tornando o atualizador "autolimpante".

