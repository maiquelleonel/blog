---
layout: post
title: 'O Harness, o SDD e o Vibe-Coding: uma abordagem de engenharia'
author: Maiquel Leonel
date: '2026-05-28'
tags:
- Spec Driven Development
- AI Agents
- Software Engineering
- DevOps
description: Mover um software além da fase mashup exige substituir a intuição por
  uma governança de engenharia rígida. Estudo de caso com Savage Worlds Dice Roller,
  Bun e Spec-Kit.
image: /assets/images/capa_harness.png
---

### Infraestrutura como contrato: o Harness contendo a entropia da automação

Mover um software além da fase “mashup” exige substituir a intuição por uma governança de engenharia rígida. No cenário atual, onde agentes de IA escrevem linhas de código em segundos, o papel do engenheiro muda de forma drástica. Em operações orientadas por modelos de linguagem, o gargalo deixa de ser a velocidade de escrita da sintaxe e passa a ser o controle de qualidade. O grande desafio do Software Engineer moderno é garantir que o sistema continue previsível, coerente e sustentável conforme múltiplos ciclos de automação começam a modificar e expandir a base de código de forma autônoma.

Recentemente, resolvi testar essa premissa de forma estruturada em um projeto relativamente pequeno, mas que impõe desafios reais de arquitetura: o **Savage Worlds Dice Roller** — uma extensão de navegador projetada para automatizar mecânicas de RPG dentro do Google Meet.

A ideia inicial parecia simples: rolar dados do meu RPG favorito, enviar os resultados no chat, controlar a iniciativa dos combatentes e sincronizar a rodada. Na prática, contudo, o projeto acabou se tornando um excelente laboratório para avaliar o impacto real do **Specification Driven Development (SDD)**, da governança orientada por contratos, de um harness de validação local e da adoção prática do ecossistema `github/spec-kit`.

Mais importante do que validar a tecnologia em si, o objetivo era entender exatamente até onde a IA realmente ajuda a engenharia antes de começar a introduzir um ruído arquitetural caótico e insustentável na base de código.

---

### O problema do “vibe coding”

{% include figure image_path="/assets/images/harness_plausibilidade_local.png" caption="A ilusão da plausibilidade local: o colapso silencioso do código sem fronteiras." alt="A ilusão da plausibilidade local: o colapso silencioso do código sem fronteiras." %}

Uma das primeiras evidências colhidas durante o projeto foi a tendência natural que os agentes de IA têm de produzir códigos altamente plausíveis, mas estruturalmente insustentáveis. LLMs não operam sob a lógica do minimalismo arquitetural ou da manutenibilidade de longo prazo; elas tendem à maximização da plausibilidade local, ou seja, leva em conta apenas o contexto imediato que ela esta editando e não como o que ela faz afeta o todo.

Quando o ambiente de desenvolvimento não impõe contratos claros, boundaries definidos, regras de negócio bem estabelecidas ou critérios objetivos de validação, o sistema entra em um fluxo constante de regressão silenciosa. O ciclo vicioso do vibe coding é previsível: o agente gera um trecho que funciona para o escopo imediato, mas quebra uma feature correlata; em seguida, ele corrige a quebra, mas refatora um bloco estável sem necessidade e altera comportamentos globais de forma imperceptível. Tudo parece individualmente coerente em nível local, mas globalmente o sistema degrada. Essa entropia ficou nítida já nas primeiras iterações do plugin, antes que eu começasse a estruturar formalmente os contratos de arquitetura.

---

### Por que Savage Worlds?

A escolha pelo motor de regras de Savage Worlds foi proposital, justamente por apresentar problemas complexos de modelagem matemática e gerenciamento de estado. A mecânica de dados do sistema não é linear, exigindo regras de *Exploding Dice* — onde o maior resultado possível em um dado libera rolagens adicionais cumulativas ad infinitum — , além do cálculo de falhas críticas combinadas entre o dado de atributo e o dado selvagem (*Wild Die*). Soma-se a isso a necessidade de gerenciar dinamicamente modificadores de bônus e ônus sobre múltiplos fluxos probabilísticos.

Outro desafio legal foi o baralho na iniciava. O sistema exige a modelagem fiel de um baralho completo de 54 cartas, incluindo os Curingas. Isso impõe à arquitetura o controle de estados primitivos e persistencia de descarte; a ordenação de desempate é baseada nos naipes, gatilhos de embaralhamento e a propagação de efeitos. Lidar com essa alternância de estados e regras determinísticas tornou o projeto o ambiente perfeito pros meus testes.

{% include figure image_path="/assets/images/harness_dice_unsplash.jpg" caption="Photo by Ian Talmacs on Unsplash" alt="Photo by Ian Talmacs on Unsplash" %}

---

### A primeira decisão importante: Separar completamente Core e Interface

A premissa inicial de design foi isolar completamente o Core da Interface. Determinei desde o primeiro ciclo que o arquivo `core.js` deveria conter apenas lógica pura e funcional. Ele não pode conhecer o DOM, o navegador, o ecossistema do Google Meet ou qualquer elemento HTML. Toda a inteligência das regras de jogo, o processamento de dados e o sorteio de cartas existem de forma isolada, enquanto o arquivo `content.js` atua estritamente como uma periferia burra de integração com o browser. Essa camada externa captura o evento gerado na interface do usuário, despacha a carga de dados para o core, recebe uma resposta puramente estruturada e injeta o texto final formatado no chat. Esse desacoplamento radical facilitou pra cacete a escrita de testes de comportamento isolados, eliminando por completo a necessidade de acoplar abstrações pesadas ou emuladores de ambiente como o JSDOM.

---

### Tá, e por que Bun?

A decisão de adotar o Bun no lugar do Node.js tradicional ou do Deno foi estritamente orientada à eficiência e à redução drástica do tempo do feedback loop, um fator crítico quando trabalhamos com automação assistida por IA. O test runner nativo do Bun executa dezenas de testes em aproximadamente 5 milissegundos rodando sobre o JavaScriptCore. Além da velocidade pura de processamento, o Bun oferece um bundler embutido que simplificou o empacotamento dos módulos ES nativos para a extensão sem o atrito de gerenciar configurações complexas de Webpack ou Vite. Esse conjunto robusto e integrado de infraestrutura permitiu mover praticamente todas as travas de validação para githooks locais executados antes do commit. O código gerado pelo agente de IA simplesmente não sai da máquina se quebrar as regras básicas ou o limite de cobertura estabelecido.

---

### Onde a IA falhou de forma perigosa

Os problemas mais complexos não surgiram na geração de sintaxe limpa, mas sim quando o projeto começou a evoluir e o agente de IA tentou tomar decisões de design de forma autônoma. O caso mais emblemático ocorreu quando o Gemini decidiu remover por completo o `github/spec-kit` do projeto. O modelo demorou de dois a quatro ciclos para compreender o contexto da ferramenta e acabou confundindo o framework oficial do GitHub com um pacote antigo e homônimo do ecossistema Node.js (AJV). Sugerindo replicar a estrutura da maneira dela mas ignorando os limites da ferramenta que roda em python. E não faz parte do projeto.

Outro erro crônico surgiu na escrita de testes. Como o sistema lida com a aleatoriedade de dados e cartas, o agente insistia em refatorar as funções de negócio e testar pontos flutuantes de forma dinâmica, mas escrevendo asserts estáticos e fixos no runner. Os testes passavam de primeira, mas mascaravam regressões silenciosas nas ramificações probabilísticas. Precisei de uns cinco ciclos de atrito manual para endurecer as restrições e forçar a IA a injetar um gerador de dados estático pra ajustar as asserções. Além disso, em momentos como a Task 002, o modelo demonstrou uma clara tendência ao overengineering desnecessário, tentando desenhar uma arquitetura complexa baseada em eventos para monitorar a presença de usuários no chat de um MVP que sequer possuía tráfego real.

---

### AGENTS.md e ARCHITECTURE.md: Restrições sobre prompts

Conforme o volume de iterações crescia, ficou evidente que guiar o comportamento do agente utilizando apenas prompts longos e voláteis escala muito mal. Para mitigar esse problema, formalizei a governança do repositório através de dois manifestos em Markdown: o `ARCHITECTURE.md` e o `AGENTS.md`. Longe de servirem como uma documentação passiva para fins organizacionais, esses arquivos funcionam como políticas executáveis de restrição para a IA.

O `ARCHITECTURE.md` delimita as fronteiras arquiteturais, contratos de interface e regras de isolamento de código do projeto. Já o `AGENTS.md` funciona como o manual de conduta operacional da LLM, especificando detalhadamente o que ela tem permissão para alterar, o que é inegociável e quais regras de negócio não podem sofrer refatoração sob hipótese alguma. Com essas barreiras documentadas no repositório, o próprio agente de IA passou a analisar suas intenções de refatoração contra os arquivos de restrição, invalidando suas próprias propostas de reescrita desnecessária antes mesmo de tocar no código fonte estável.

---

### Entrando no Spec-Kit via gemini-cli

A introdução do `github/spec-kit` ocorreu com a arquitetura do plugin já estabilizada pelos manifestos de restrição, servindo como uma excelente validação de adoção do framework em bases de código legadas. O speckit funciona diretamente no `gemini-cli`, transformando a governança conceitual em um pipeline opinativo e sequencial comandado por CLI. O primeiro comando depois de tudo instalado é o `/speckit.constitution`, que faz o modelo a mapear o repositório, assimilar o `ARCHITECTURE.md` e o `AGENTS.md` e entender as fundações da arquitetura na pasta `.specify/memory/`. A partir dessa consciência técnica, o fluxo avança pelas fases de especificação detalhada da issue (`/speckit.specify`), desenho estruturado do plano de mudanças (`/speckit.plan`) e consolidação do checklist de tarefas e critérios de aceitação (`/speckit.tasks`); por fim `/speckit.implement` para codificar a solução.

Esse cerimonial retira a liberdade criativa da IA; eu nem abria mais o `core.js` ou `content.js` durante o processo. Se noto que o modelo começou a poluir o plano com tarefas redundantes ou desalinhadas, edito o enunciado do escopo, rodo o comando `/speckit.clarify` e o framework reconfigura automaticamente todo o grafo de dependências das tarefas. O experimento também expôs uma resistência comportamental interessante das LLMs: em múltiplos momentos, o Gemini tentava me convencer a abandonar a burocracia do Spec-Kit, alegando que já havia compreendido o padrão e poderia codificar diretamente "na mão" para acelerar o processo. As IAs tentam constantemente otimizar o ganho de curto prazo removendo a fricção operacional; cabe ao engenheiro manter a rigidez framework assim com fazemos com Django ou Rails.

---

### Quality Gates e o Harness Operacional

O sucesso prático do laboratório residiu na robustez do Harness de automação local, desenhado sob a premissa de que nenhuma modificação de código atinge o repositório remoto sem passar por travas estritas de validação. O pipeline de integração une branchs principais protegidas e validação contínua no CI via GitHub Actions. O runner de testes foi configurado via `test:threshold` para exigir cobertura obrigatória de 100% no core do sistema; se a IA introduzir qualquer linha sem teste, o build falha. Como a suíte do Bun executa em 5 milissegundos, integrei os testes em um git-hook pre-commit. Se o agente de IA falhar em atender ao contrato ou introduzir uma regressão lúdica, a ferramenta barra a operação localmente e mantém o modelo em um loop contínuo de autocorreção antes que qualquer linha de código inválida seja empurrada para a esteira remota do GitHub Actions.

A definição e a manutenção dos arquivos `AGENTS.md` e `ARCHITECTURE.md` foram mantidas sob controle estritamente humano e manual. Enquanto deleguei ao agente a capacidade de codar e gerar artefatos de tarefas e planos, as definições de boundaries, tolerâncias de erro e contratos abstratos de negócio permanecem comigo. Essa separação de responsabilidades provou ser obrigatória para o sucesso de qualquer projeto sério que utilize automação assistida por IA.

---

### O trade-off real do SDD

Adotar o Spec-Driven Development significa aceitar desacelerar brutalmente os primeiros 20% do projeto para obter uma aceleração previsível e exponencial nos 80% restantes. Esse modelo impõe um custo real de overhead cognitivo e um processo burocrático massivo no início do ciclo. As primeiras tentativas foram exaustivas, demandando revisões manuais constantes, respostas a perguntas redundantes do modelo e um esforço alto de engenharia para contornar problemas de compatibilidade do pacote `node-pty` entre o `gemini-cli` e o Bun.

No início, a sensação é de pura burocracia, dado que uma única linha de intenção gera dezenas de arquivos Markdown populando a pasta `.specify`. O ganho de eficiência só se manifestou após algumas iterações, quando o aprendi a escrever specs melhores. Quanto mais precisa, concisa, granular e contextualizada for a spec inicial, mais liso o agente executa o código final.

Com a maturidade obtida no uso do framework, o tempo de ciclo para implementar uma nova funcionalidade completa despencou para menos de trinta minutos: gastam-se cerca de dois minutos definindo o escopo, vinte minutos refinando e validando o plano gerado pelo agente, cinco minutos na escrita automatizada do código fonte via `/speckit.implement` e cinco minutos em um teste manual de fumaça dentro do navegador.

---

### Os Números e o Ganho Real

A engenharia baseada em métricas sólidas demonstra que o ganho real de produtividade ao adotar o SDD e o Spec-Kit reside na redução do Custo de Mudança e no controle estatístico de falhas. O repositório atualmente conta com 29 testes, o tempo de compilação fixado em 4 milissegundos e uma taxa histórica de regressão controlada em 3.77%. O esforço de desenvolvimento do plugin estabilizou em uma distribuição onde 80% do código fonte é escrito de forma automatizada pela IA e 20% do tempo é despendido no design humano de contratos e especificações. O tempo necessário para onboardar e estabilizar uma nova feature caiu de um ciclo errático de até duas horas de iteração com IA para um fluxo determinístico de menos de meia hora.

Essa mudança transformou radicalmente a minha postura em Code Reviews: o foco deixou de ser a revisão estática de sintaxe ou estilo de escrita — fatores que viraram subproduto irrelevante do pipeline automatizado. Hoje, o diff do pull request é auditado estritamente para avaliar a preservação de contratos de dados, o isolamento dos boundaries e o respeito às regras de negócio mapeadas na especificação. Se a IA cumpre o contrato, a implementação física do algoritmo torna-se secundária.

---

### Conclusão: Governança é o novo Framework

{% include figure image_path="/assets/images/harness_governanca_eterna.png" caption="O código atual é efêmero e descartável. A governança e os contratos são eternos." alt="O código atual é efêmero e descartável. A governança e os contratos são eternos." %}

A indústria de tecnologia atual sofre de um desalinhamento sério: muito se propaga sobre a eficiência operacional do desenvolvimento por IA, mas pouquíssimos casos reais de engenharia estruturada são expostos (muito se fala, pouco se mostra). O mercado vive um cenário saturado de discursos evangelistas baseados em truísmos comerciais e demonstrações rasas em Streamlit que ocultam problemas severos de concorrência, conciliação de estado e manutenibilidade a longo prazo. Foca-se no ganho imediato de digitação de código e negligencia-se a arquitetura de software, gerando um débito técnico invisível e catastrófico.

A evolução prática deste laboratório aponta para a mudança de paradigma inevitável na carreira técnica de engenheiros seniores e líderes de plataforma. Na era dos agentes, o profissional perde relevância se indicar que quer se posicionar apenas como coder. Escrever linhas de código virou uma commodity de execução automatizada e barata. O engenheiro moderno precisa subir um degrau na abstração técnica e assumir o papel de arquiteto do sistema que gera o sistema. Nosso valor reside em desenhar as fronteiras invisíveis da arquitetura, estabelecer as restrições de governança das LLMs e garantir a solidez das esteiras automatizadas de validação lógica. O código gerado tornou-se efêmero e descartável. Se eu deletar a pasta `src/` do repositório hoje, o sistema não morre; ele continua preservado nas especificações, nos contratos de dados, nas travas do Harness e nas regras de negócio da pasta `.specify`. O software moderno deixou de ser um bloco de código fonte para se transformar em uma compilação de constraints arquiteturais controladas por humanos.

---

🔬 **Repositório do projeto:** [https://github.com/maiquelleonel/savage-dice-roller](https://github.com/maiquelleonel/savage-dice-roller)  
🎲 **Link do plugin:** [https://chromewebstore.google.com/detail/savage-worlds-dice-roller/gbchefnadoljbafdaaccjkoffghbagoe](https://chromewebstore.google.com/detail/savage-worlds-dice-roller/gbchefnadoljbafdaaccjkoffghbagoe)

