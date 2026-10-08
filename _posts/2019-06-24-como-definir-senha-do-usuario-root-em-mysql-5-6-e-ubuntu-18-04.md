---
title: "Como definir senha do usuário root em MySQL 5.6+ e Ubuntu 18.04+"
seo_title: "Como definir senha do root no MySQL 5.6+ e Ubuntu 18.04+ | Maiquel Leonel"
seo_description: "Dica rápida de terminal sobre como alterar o plugin de autenticação e definir a senha de root no MySQL em versões modernas do Ubuntu."
date: 2019-06-24
author: "Maiquel Leonel"
status: published
image: /assets/images/0_ShAvuMKBue1nlPec.jpg
image_caption: "Photo by James Sutton on Unsplash"
tags:
  - ubuntu
  - mysql
  - linux
  - terminal
  - devops
canonical_url: "https://maiquelleonel.com.br/blog/como-definir-senha-do-usuario-root-em-mysql-5-6-e-ubuntu-18-04/"
medium_url: "https://maiquelleonel.medium.com/como-definir-senha-do-usu%C3%A1rio-root-em-mysql-5-6-e-ubuntu-17-10-501e74767e63"
devto_url: ""
description: "Uma dica rápida de terminal sobre como alterar a senha do usuário root do MySQL 5.6+ no Ubuntu 18.04 e mais recentes."
---

# Como definir senha do usuário root em MySQL 5.6+ e Ubuntu 18.04+

Uma dica rápida para definir a senha para o usuário `root` nas versões mais recentes do Ubuntu.

![[0_ShAvuMKBue1nlPec.jpg|Photo by James Sutton on Unsplash]]
*Photo by [James Sutton](https://unsplash.com/@jamessutton_photography) on [Unsplash](https://unsplash.com/)*

---

Primeiro, acesse o MySQL como superusuário via terminal:

```bash
sudo mysql -u root
```

Depois, basta atualizar o plugin de login e conceder o grant para o usuário root com a seguinte query SQL:

```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'sua-senha-aqui';
```

Atualize os privilégios com o comando:

```sql
FLUSH PRIVILEGES;
```

Saia do console do MySQL:

```text
\q
```

E teste a nova autenticação direto no terminal:

```bash
mysql -u root -p
```

Ao digitar a senha escolhida, o prompt do MySQL deve abrir normalmente.

E é isso! 🫴
