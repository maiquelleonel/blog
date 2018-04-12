---
title: "Usando Raspberry pi, rsync e inotify para um video wall de baixo custo"
date: 2018-04-10 01:15:17 -0300
layout: post
author: Maiquel Leonel
permalink: /2018/04/10/usando-raspberry-pi--rsync-e-inotify-para-um-video-wall-de-baixo-custo/
tags:
  - linux
  - Raspberry pi
  - rsync
  - inotify
  - video wall
category: linux
---

Sabe aquele brinquedo que tu sempre quis brincar, desmontar e entender como funciona?
Tipo o Atari que tu teves na infância? Ok no meu caso um [CCE Supergame](http://www.museudovideogame.org/img/c/1200/900/produto_imagem/2015/03/supergame-cce-vg-2800-com-tres-cartuchos.jpg) mas né... Anos 80,
portos fechados, a gente nem era tão exigente com as marcas naquela época... Enfim, sempre me senti assim com o Raspberry Pi.


O Raspberry Pi é um "miniPC", de baixíssimo custo. Tu encontras a versão mais potente dele, a Model B+, por cerca de U$40,00. Sim o "PC" completo, com processador Quad Core 1.2GHz, 4 portas USB, rede wifi e RJ-45, saída HDMI e 1GB de RAM por 40 "trumps"?! É muito barato! Lembrando que outras versões não tão atuais do PCzinho com menos processamento e RAM são ainda mais baratas! Chegando a versões de U$20,00 ou menos.

{% include figure image_path="https://eteknix-eteknixltd.netdna-ssl.com/wp-content/uploads/2014/07/raspberry-pi-B+-640x431.jpg" caption="Raspberry Pi 3 model B+ 1GB de ram" %}

Agora tu deves estar se perguntando: "Tá! Mas o que eu farei com um Hardware tão modesto?" Bom, existe uma série de utilidades pro PCzinho. Sério são muitas mesmo! Uma olhada nesse [site de projetos](https://www.hackster.io/raspberry-pi/projects) já te deixa envolvido por horas a fio.

Falando da distro GNU/Linux que o RaspberryPi embarca: ela é a [Raspbian](https://www.raspbian.org/), uma derivada de [Debian](https://www.debian.org/) com os drivers, ambiente gráfico e outros apps escolhidos "a dedo" pra funcionar perfeitamente no PCzinho. Sou entusiasta de Debian (e derivadas) desde 2004/2005, não tive dificuldade nenhuma. Foi só escolher os softwares certos e correr pro abraço!

---

## O problema

O projeto é bem simples: tocar videos de propaganda em loop nos "terminais" do quiosque, de maneira que os vídeos pudessem ser periodicamente atualizados. Basicamente: um "videolooper atualizável". Depois de algumas tentativas com com outras ferramentas conhecidas de "arquivos em nuvem" que não rodaram bem com o RaspberryPi, decidimos resolver de uma maneira mais "braçal" porém funcional.

## A solução

A solução que desenhamos foi bem sucinta: um usuário sobe um video para um FTP específico, o RaspberryPi monitora esse endereço via `rsync` e o `inotify-tools` informa o sistema operacional que recebeu um novo vídeo, o S.O. por sua vez faz um reboot para que o novo video comece a tocar no video looper e tudo sincroniza automágicamente :D. Barbada né? Pois é, nem tanto.

## A implementação

Depois de instalado o videolooper conforme esse [tutorial aqui](https://learn.adafruit.com/raspberry-pi-video-looper/overview), precisei mexer na cron do Raspberry para agendar a execução tanto o rsync quanto do inotify. O detalhe é que, seja lá por qual motivo, a cron de usuário simplesmente não funcionou. De jeito nenhum! Nem agendando na cron do root, nem salvando do `/etc/hourly.d/`. O jeito foi salvar na cron do sistema mesmo. Depois ainda descobri no stackOverflow que é um "detalhe" da própria distro. Feito isso, conseguimos o comportamento esperado.

---

### Super detalhamento

A primeira coisa a se fazer é instalar as libs rsync e inotify-tools com o apt velho de guerra. Pensei que fosse preciso configurar algum PPA mas pra minha surpresa ambos estavam no mirror do Raspbian. Então foi muito simples.

```shell
$ sudo apt install rsync inotify-tools
```

Dependências instaladas, o show pode começar. A primeira tarefa é fazer o rsync monitorar a pasta remota na pasta que o videolooper lerá. Isso eu farei por um shellscript. Crio um arquivo chamado `atualizador.sh`, dou permissão de execução com o comando `chmod +x atualizador.sh`, e adiciono o seguinte conteúdo:

```shell
#!/bin/bash

RSYNC=/usr/bin/rsync
SSH=/usr/bin/ssh
KEY=/home/pi/.ssh/remoteuser_rsa.pem
RUSER=remoteuser
RHOST=remotehost.com.br
RPATH=/home/remoteuser/videos/*
LPATH=/home/pi/Videos/

$RSYNC -razp --force --delete-before --ignore-errors -e "$SSH -i $KEY" $RUSER@$RHOST:$RPATH $LPATH
exit 0
```

Explicando detalhadamente: o que fiz foi deixar em variáveis tudo o que vamos precisar para diminuir o tamanho do comando e melhorar a legibilidade. Ficou uma variável por linha e o comando no final, façinho!

Onde:
- RSYNC, é o path para o binário do rsync
- SSH é a path para o shell
- KEY é a chave de acesso (explico melhor em seguida)
- RUSER é o usuário para conectar no servidor remoto
- RHOST é o endereço do servidor remoto
- RPATH é o caminho onde os vídeos serão upados períódicamente
- LPATH é o caminho local onde serão salvos os vídeos

A última linha é o comando em si, as opções são as seguintes:
- `-r` de cópia recursiva
- `-a` de modo arquivamento
- `-z` para compactar o arquivo durante a transferência (e descompactar no destino)
- `-p` para preservar as permissões do arquivo
- `--force` para executar sem confirmação
- `--delete-before` para excluir o destino antes da tranferência
- `--ignore-errors` para não levantar erros no shell, travando o script
- `-e` para dizer pro rsync usar a autenticação via SSH em detrimento da SFTP, assim não trafegamos senhas por texto plano pela rede.

\*Aqui poderíamos usar um SFTP sem grandes problemas a não ser a senha desse usuário restrito rolar pela rede indiscriminadamente. Logo o SSH sobre SFTP se mostra mais seguro e rápido também. Mas vai de cada cenário.

Feito isso, agora temos que dizer pro Raspbian que queremos consultar o servidor remoto, a cada 1h, em busca de  novos videos. Fazemos isso agendando na crontab do Raspbian, adicionando ao final do arquivo `/etc/contrab` a seguinte linha:

```shell
* */1 * * * root /home/pi/atualizador.sh
```

Só isso bastaria para manter o Raspberry Pi atualizado, entretanto o processo videolooper não era morto pelo S.O. para trocar o video em exibição. A solução aqui foi fazer reboot. Sendo assim, ao final do boot o videolooper sobe e exibe o video atualizado. Com um S.O. rodando em um SDCard, o boot não leva mais de 10 segundos. Um tempo bem aceitável pra um monitor de propaganda.

---

Lembrei que tinha feito um teste para uma vaga de emprego anos atrás onde o usuÁrio fazia algo muito similar ao nosso cenário: upava um arquivo com uma métrica expecífica em um diretório e um script fazia o parse desse arquivo de lote, resultando em outros arquivos com conteúdo distinto. Durante a pesquisa pra resolver esse teste foi que eu conheci o `inotify-tools`. O que esse carinha faz é te dar alguns eventos em arquivos e/ou diretórios que tu configuras para ele monitorar. Assim tu podes saber se determinado recurso foi atualizado, excluído, criado, modificado etc.

Configurar o `inotify-tools` é algo bem fácil. Criei um arquivo chamado `monitor.sh`, com permissão de execução executando um `chmod +x monitor.sh` e colei o seguinte conteúdo nele:

```shell
#!/bin/sh
inotifywait --recursive --monitor --quiet --event close_write --format '%f' /home/pi/Videos/ |
while read FILE ; do
    reboot
done
```

O que eu faço aí é "dizer" pro inotifywait: execute um `sudo reboot` sempre que algum recurso de formato '%f' (arquivo) no diretório `/home/pi/Videos/` for **fechado para escrita**, sem avisos, em modo monitor, de maneira recursiva. Os parâmetros são autoexplicativos.

Ao executar o monitor com um `./monitor.sh` o inotify faz seu trabalho perfeitamente. Porém, é necessário que pasta seja monitorada pelo inotify na sequência do startup do sistema. Foi só colocar ao final do `/etc/crontab` a linha:

```shell
@reboot root  /home/pi/monitor.sh
```

O Raspberry já esta configurado e pronto pra uso. Bastando instalar os monitores, conectar o monitor na saida HDMI e partir pro abraço! Lembrando que como estou usando a crontab do sistema operacional, é preciso declarar o usuário que executará o comando.

---

## pós instalação

Depois de pronto, acabamos descobrindo que, por algum motivo, o rsync não deletava os arquivos nos Raspberry, mesmo eles sendo deletados do servidor remoto. A solução foi: criar um arquivo vazio com o mesmo nome do video e mandar limpar arquivos vazios junto com a execução do `atualizador.sh`. Como fiz isso? Simples! Adicionei a seguinte linha logo após o comando do rsync:

```shell
find /home/pi/Videos/ -type f -size 0 -delete
```
Ou seja, busque nesse diretório por recursos tipo file, de tamanho 0 bytes e delete. Assim o atualizador ficou "autolimpante".

Primeiramente, gostaria de agradecer quem leu até aqui. Me esforcei pra ser o mais detalhado e sucinto na explicação de cada passo. "Segundamente", se gostou desse conteúdo considere compartilhar com a galera.
Considere ainda me seguir no [github](http;//github.com/maiquelleonel) e/ou nas redes sociais. E claro! Deixe seu comentário em caso de dúvida, crítica ou contribuição :). Toda a ajuda é bem-vinda!

Um abraço!
