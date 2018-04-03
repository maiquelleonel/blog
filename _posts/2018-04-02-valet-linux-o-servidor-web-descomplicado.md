---
layout: post
title: "Valet Linux: o servidor web descomplicado"
author: "Maiquel Leonel"
date: 2018-04-02
tags:
  - valet
  - laravel
  - nginx
  - php
category: "desenvolvimento web"
---

O [Laravel](https://laravel.com/) possui uma série de facilidades em termos de ambiente pro desenvolvedor. Existe um cara chamado [Homestead](https://laravel.com/docs/5.6/homestead), um ambiente parrudo e com muita coisa otimizada pro Laravel. Porém foi um carinha chamado Valet que roubou minha atenção.

{% include figure image_path="https://cdn-images-1.medium.com/max/800/1*Y7Uj0OjcIP5eFHdkQQRUmA.png" caption='O servidor "de bolso"' %}

O Valet é um ambiente de desenvolvimento minimalista e altamente descomplicado, otimizado para o Laravel e sem uma grande parafernália de instrumentos e configurações por parte do desenvolvedor. Basta clonar o código, apontar o navegador pra pasta do projeto e pronto! Tudo funcionando nos “trinks”! Originalmente liberado para Mac, no github encontrei o [Valet para Linux](https://laravel.com/docs/5.6/valet), com um port bem fiel ao original.

Olha, eu garanto que depois de descobrir o Valet tu nunca mais vai querer saber de configurar ambientes de desenvolvimento na "unha". Sem Vagrant, sem `/etc/hosts` e o mais legal: com **compartilhamento público de url**  usando tunelamento local e "automágico".

Ainda não sei se a versão pra windows já está estável, mas sei de uma galera que
está tentando portar. Tu encontra o projeto em

\*Ainda não sei se a versão pra windows já está estável, mas sei de uma galera que está tentando portar. Se for do teu interesse o projeto está em [Valet-windows](https://github.com/cretueusebiu/valet-windows).

---

## Instalação

O Valet-linux é construído para PHP e com o PHP. É necessário pelo menos o PHP5.6 e claro o [composer](http://getcomposer.org). Antes de instalá-lo é preciso baixar algumas dependências para que a mágica do Valet aconteça. Assumindo que tu estejas no Ubuntu:

```
sudo apt install network-manager libnss3-tools jq xsel
sudo apt install php*-cli php*-curl php*-mbstring php*-mcrypt php*-xml php*-zip
sudo apt install php*-sqlite3 php*-mysql php*-pgsql
```
<sup><sup>_Troque os * pela versão do PHP em uso._</sup></sup>

Para outras distros e mais detalhes a [documentação](https://cpriego.github.io/valet-linux/requirements) é bem completa.
Garantidas as dependências, basta instalar o projeto com:

`composer global require cpriego/valet-linux`

Depois de finalizar a parte do composer basta rodar `valet install`.
O Valet identifica a tua distribuição e configura em background tudo que ele
precisa pra funcionar, o [Nginx](https://nginx.org/en/), o [Dnsmasq](https://en.wikipedia.org/wiki/Dnsmasq) e todo o resto.

### Agora a mágica começa!

{% include figure caption="servidor automágico" image_path="https://cdn-images-1.medium.com/max/800/1*X8OYKHlK_ZWpLbK0Pxts9g.jpeg" %}

Por padrão o Valet define um "dominio" inicial `.test` TLD, que tu podes mudar facilmente com o comando `valet domain [domain]`. Entre no diretório do seu Laravel, ou no diretório dos seus projetos, avise o Valet que é pra ele monitorar ali com o comando `valet park`. E é isso! **Sim! É só isso!**
Para ver ele em ação basta um `valet open` ou apontar o browser para [meuprojeto].test e pronto.
Que mumuzinho né?! Fala sério! :D

#### Outros recursos

O Valet também pode criar links entre projetos ou para pastas que não estão na pasta monitorada.
Por exemplo, pra fazer o phpmyadmin funcionar com ele, navegue até o diretório `/usr/share/phpmyadmin`
e dentro dele execute um `valet link phpmyadmin`. A partir daí, accesse em `phpmyadmin.test`. Isso
pode ser feito para quaisquer diretórios, inclusive dentro do "park".

Outras "tricks" interessantes são: deixar a rota forçando https, com o comando `valet secure`. (Para reverter basta um
`valet unsecure` no mesmo diretório) e a mais legal de todas, o comando `valet share`.

Esse comando possibilita ao Valet criar facilmente, através do [ngrok](http://ngrok.io), um túnel de DNS
que deixa teu projeto acessível pra todo mundo! Através de um link que pode durar até 7 horas. Demais né?! Para mais opções, comandos e configurações use `valet list`.

Vale salientar que o Valet não é um substituto completo pro Vagrant ou pro
Homestead. O foco dele é ter um ambiente local, completo, simples e minimalista.
Até o momento, o Valet tem drivers para [Laravel](https://laravel.com) e [Lumen](https://lumen.laravel.com/), além de [Symfony](https://symfony.com/), [Zend](https://framework.zend.com/)
[CakePHP 3](https://cakephp.org/), [WordPress](https://wordpress.org/), [Bedrock](https://roots.io/bedrock/), [Craft](https://craftcms.com/), [Statamic](https://statamic.com/), [Jigsaw](http://jigsaw.tighten.co/), HTML estático.

---

Era isso! Se gostou considere compartilhar com a “rapeize”, me seguir no [github](http://github.com/maiquelleonel)
e/ou nas redes sociais.

Abraço!
