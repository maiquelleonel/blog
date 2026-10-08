---
layout: post
title: "Como rodar todos os testes pelo poetry usando a linha de comando"
seo_title: "Como rodar todos os testes pelo poetry usando a linha de comando | Maiquel Leonel"
seo_description: "Aprenda como criar um script e atalho no Poetry para executar toda a suite de testes do Pytest com um simples comando no terminal."
date: 2021-03-12
author: "Maiquel Leonel"
status: published
image: /assets/images/capa_poetry.png
image_caption: "Atalho customizado no Poetry para rodar Pytest"
tags:
  - python
  - poetry
  - pytest
  - terminal
canonical_url: "https://maiquelleonel.com.br/blog/como-rodar-todos-os-testes-pelo-poetry-usando-a-linha-de-comando/"
medium_url: "https://medium.com/@maiquelleonel/como-rodar-todos-os-testes-pelo-poetry-usando-a-linha-de-comando-f5b342a34dd9"
devto_url: ""
description: "Uma dica rápida de terminal sobre como criar um script personalizado no Poetry para rodar todos os testes do Pytest com facilidade."
---

Uma coisa que eu sempre gostei foi de atalhos curtos para rodar comandos complexos. São mais rápidos de digitar (:D) e mais simples de lembrar. O comando `poetry new [meu-projeto]` provê uma estrutura básica para um novo projeto. Contudo, o poetry, por padrão, não possui um comando pronto que automatiza a execução dos testes, pelo menos não de maneira intuitiva e automática. Como precisei procurar, resolvi escrever essa dica aqui pra ajudar.

Para deixar a execução de testes muito mais simples, faz-se necessário uma pequena configuração extra, de maneira que os testes passem a rodar com um `poetry run tests`, por exemplo.

---

Primeiramente, precisamos criar o código que execute o comando do python e encapsulá-lo em uma função. Sabendo disso, criamos o arquivo `scripts.py` na raiz do projeto com o seguinte conteúdo:

```python
import subprocess


def tests():
    subprocess.run(["python", "-u", "-m", "pytest"])
```

Depois basta dizer pro poetry que queremos um novo comando chamado `tests` e que esse comando executa a função tests.

No arquivo `pyproject.toml`, logo antes de `[build-system]`, basta adicionar o seguinte trecho:

```toml
[tool.poetry.scripts]
tests = "scripts:tests"
```

E *that’s it!* Agora basta rodar `poetry run tests` para que o poetry rode todos os arquivos de testes salvos na pasta `tests/*`.

Massa, né?!

Se gostou do post ou ele foi útil de alguma forma eu adoraria saber. Considere também me seguir no [GitHub](https://github.com/maiquelleonel) e/ou nas redes sociais. Meu muito obrigado pra quem leu até aqui!
