---
layout: post
title: 'AI Value Creators: Além da Mentalidade de Mero Usuário de IA'
author: Maiquel Leonel
date: '2026-09-22'
tags:
- Artificial Intelligence
- Fin Ops
- Sl Ms
- Software Engineering
description: Por que alugar inteligência genérica de terceiros destrói a margem e
  não cria fosso competitivo. Como se tornar um AI Value Creator com dados próprios
  e SLMs eficientes.
image: /assets/images/1_cWmjb1o5k0OpjaqluoBekg.png
image_caption: 'Além da mentalidade de mero usuário de IA: construindo valor com SLMs
  e modelos locais'
---

Passei os últimos dias lendo _AI Value Creators_, livro lançado pela O’Reilly reunindo Rob Thomas, Paul Zikopoulos e Kate Soule. A maioria das publicações sobre IA generativa lançadas recentemente parece escrita por quem nunca colocou uma linha de código em produção ou nunca precisou justificar uma fatura de nuvem no fim do mês. Esse livro foi na contramão.

Os autores tocam num ponto que pouca gente na liderança quer admitir em voz alta: quase todo mundo que diz estar inovando com IA hoje só está alugando inteligência de prateleira. A empresa compra licenças de copilotos, espalha chamadas de API genéricas pelo sistema, monta um chatbot por cima de um fluxo que já era quebrado e chama isso de estratégia.

Na prática, isso cria duas coisas: custo operacional imprevisível e zero diferenciação competitiva. Se você consome exatamente o mesmo modelo que o seu concorrente, pagando o mesmo preço de tabela, a sua vantagem técnica é nula. Você não está criando valor de longo prazo; está apenas bancando o custo de inferência dos grandes provedores enquanto entrega contexto de negócio de bandeja.

Steve Jobs gostava de citar aquele estudo clássico que comparava a eficiência de locomoção de várias espécies: o condor liderava com folga, mas um ser humano montado em uma bicicleta superava qualquer animal do planeta. Jobs dizia que o computador era a bicicleta da nossa mente. A IA generativa prometia o mesmo salto. A diferença é que a maioria das organizações hoje não comprou uma bicicleta: está pagando aluguel por minuto numa ergométrica fechada, gerando números de vaidade sem sair do lugar.

A virada proposta em _AI Value Creators_ é clara: a engenharia precisa fazer a transição de mero usuário (_AI User_) para criador de valor (_AI Value Creator_). Isso exige parar de tratar LLM como mágica externa e começar a tratar inteligência como infraestrutura: dominar modelos pequenos e especializados (SLMs), orquestrar roteamento de inferência, treinar sobre dados proprietários e trocar o improviso de prompts gigantescos por runtimes determinísticos.

Abaixo organizei as principais teses do livro, cruzando o framework dos autores com a realidade prática de arquitetura, custos e produto.

---

### 1. O Momento Netscape e a Ilusão do `+AI`

A popularização dos Modelos de Linguagem de Larga Escala (LLMs) marca o que os autores chamam de **Momento Netscape**. Em 1994, o navegador Netscape não inventou a internet, mas transformou protocolos acadêmicos complexos (TCP/IP, FTP, Telnet) em uma interface gráfica tangível para as massas. O prompt fez o mesmo com a inteligência artificial: transformou matrizes matemáticas de alta dimensão em conversação em linguagem natural.

O erro da liderança corporativa é confundir a facilidade da interface com estratégia de negócio.

MINDSET TRADICIONAL (+AI)                  MINDSET NATIVO (AI+)  
┌────────────────────────────┐  ┌────────────────────────────────┐  
│  Processo de Negócio       │  │      Supervisão Humana         │  
│  Legado e Fragmentado      │  │   (Estratégia e Alinhamento)   │  
├────────────────────────────┤  ├────────────────────────────────┤  
│ [ + AI Wrapper / Chatbot ] │  │ [ Agentes e Automação de IA ]  │  
│ (Remendo colado na ponta)  │  │ (Executam o trabalho de base)  │  
└────────────────────────────┘  ├────────────────────────────────┤  
                                │ Arquitetura de Informação (IA) │  
                                │ (Data Fabric, Lakehouse, RAG)  │  
                                └────────────────────────────────┘

A maioria dos orçamentos corporativos é consumida na mentalidade **+AI** (_“vamos colocar um pouco de IA nos sistemas que já temos”_). Cria-se um assistente virtual por cima de um ERP obsoleto ou um gerador de e-mails em cima de um CRM bagunçado. Com isso, o resultado é previsível: **automatiza-se a ineficiência**.

No modelo **AI+**, a ordem se inverte:

1. **Decomposição Granular:** Quebra-se o fluxo de trabalho em componentes elementares de lógica e dados.
2. **Execução Autônoma:** Atribui-se o trabalho mecânico e repetitivo (_rote work_) a modelos eficientes e agentes especializados.
3. **Supervisão Humana de Alto Valor:** O profissional deixa de operar a manivela para atuar no controle de qualidade, na orquestração e nas decisões estratégicas no topo do processo.

#### A Regra de Ouro do Orçamento: Shift Left antes de Shift Right

Antes de escrever qualquer linha de código, o livro propõe uma classificação direta para qualquer iniciativa de IA em duas dimensões financeiras:

- **Gastar Dinheiro para Economizar Dinheiro (Renovação / Shift Left):** Foco em eficiência interna, redução de custos operacionais e corte de retrabalho.
- **Gastar Dinheiro para Fazer Dinheiro (Inovação / Shift Right):** Criação de novos produtos, canais de receita e modelos de negócio.

O conselho dos autores para quem está começando é simples: **comece pela Renovação**. O conceito de _Shift Left_ vem do desenvolvimento de software e manufatura: capturar defeitos ou ineficiências no início do ciclo é ordens de grandeza mais barato do que lidar com eles quando já estão na mão do cliente.

O livro traz números impressionantes para justificar essa postura:

- **A complexidade de software moderna:** Um carro atual roda com cerca de 100 milhões de linhas de código, comparado a modestos 14 milhões de um Boeing 787. Um bug em produção automotiva exige recalls caríssimos ou patches remotos de alto risco de cibersegurança.
- **O custo da saúde preventiva:** Nos EUA, o tratamento de úlceras diabéticas custa cerca de US$ 58.000 por paciente ao ano, contra US$ 17.000 de um paciente sem complicação. Usar IA para detectar inflamações térmicas precoces nos pés (termometria em tapetes conectados) é um clássico caso de _Shift Left_ salvando membros e poupando bilhões ao sistema.

Quando você automatiza processos internos de baixo risco com IA, você não apenas blinda a operação de vexames públicos de alucinação, como gera um excedente de caixa: o orçamento economizado na **Renovação** é o combustível limpo que financia as apostas de **Inovação**. Na própria IBM, a automação interna de rotinas operacionais (projeto _Client Zero_) gerou mais de US$ 3 bilhões em economias que foram reinvestidas diretamente no desenvolvimento de novos produtos.

---

### 2. A Macroeconomia Cruel e as Três Equações da IA

A urgência da adoção de IA não nasce do entusiasmo do Vale do Silício, mas das restrições do cenário macroeconômico global.

Em 1907, no discurso de formatura em Princeton, o futuro presidente norte-americano Woodrow Wilson descreveu uma era _“perturbada, confusa e assustada com as suas próprias forças”_, marcada pela ansiedade da ascensão do capitalismo industrial. O sentimento se repete a cada grande salto técnico: da recusa da Rainha Elizabeth I em patentear o tear mecânico em 1589 por medo do desemprego dos tecelões, até os debates sobre o impacto da IA generativa no trabalho cognitivo.

Para compreender a necessidade dessa transição sem cair no fatalismo, os autores propõem três equações econômicas fundamentais.

#### Equação 1: A Equação de Crescimento do PIB

> Δ PIB = ↑ População + ↑ Capital + ↑ Produtividade

Historicamente, o crescimento econômico repousa sobre três alavancas:

- **População:** Quase todas as nações desenvolvidas e em desenvolvimento enfrentam queda vertiginosa nas taxas de fertilidade (_Silver Tsunami_). Menos pessoas entram na força de trabalho ativa, gerando escassez crônica de mão de obra qualificada e perda de memória institucional (_enterprise amnesia_).
- **Capital e Dívida:** A era de quinze anos de juros reais negativos e dinheiro fácil acabou. O acesso ao crédito encareceu.
- **Produtividade:** Com a retração demográfica e o capital restrito, **a produtividade é a única alavanca viável** para sustentar a margem e o crescimento das organizações.

Segundo o _McKinsey Global Institute_, a taxa de crescimento da produtividade nos EUA tem oscilado em modestos 1,4% ao ano, enquanto o Canadá registrou contração de 1,8% em 2023 comparado a 2019. Se os EUA recuperassem as taxas históricas de produtividade do pós-guerra, adicionariam cerca de US$ 10 trilhões ao seu PIB — um terço de toda a sua economia.

#### Equação 2: A Fórmula do Sucesso em IA

> AI Success = Models + Data + Governance + Use Cases

O erro comum é focar 90% do orçamento nos **Modelos** (comprando acessos e GPUs) e ignorar os demais componentes:

- **Data (O Diferencial Real):** Praticamente 100% dos dados públicos da internet já foram raspados e indexados pelos grandes modelos de fundação. Menos de **1% dos dados corporativos privados** está presente neles. A única vantagem competitiva perene está no conhecimento proprietário que não pode ser raspado por concorrentes.
- **Governance (A Licença para Operar):** Monitoramento contínuo contra alucinações, deriva de modelo (_drift_), viés algorítmico e violações de privacidade.

**Use Cases (Foco de Negócio):** Projetos que resolvem dores concretas de renovação (economizar dinheiro) ou inovação (gerar novas receitas), fugindo dos _“projetos de estimação”_ de ciência de dados que morrem no laboratório.

#### A Arquitetura do “Bolo em Camadas” (Layer Cake)

Para a equação de sucesso não virar apenas um punhado de scripts soltos na nuvem, o livro propõe uma arquitetura corporativa em cinco camadas integradas:

ARQUITETURA DA PLATAFORMA DE IA (LAYER CAKE)  
┌───────────────────────────────────────────────────────────┐  
│ 5. Agentes e Assistentes (Automação de tarefas e AX)      │  
├───────────────────────────────────────────────────────────┤  
│ 4. SDKs & APIs (Pontos de integração para os sistemas)    │  
├───────────────────────────────────────────────────────────┤  
│ 3. Plataforma de IA & Dados (Lakehouse + Governança Ativa)│  
├───────────────────────────────────────────────────────────┤  
│ 2. Serviços de Dados (Data Fabric: IA precisa de uma IA)  │  
├───────────────────────────────────────────────────────────┤  
│ 1. Base Híbrida & Aberta (On-premises, Edge e Multi-Cloud)│  
└───────────────────────────────────────────────────────────┘

1. **A Base Híbrida e Aberta:** A ilusão da nuvem única morreu. A infraestrutura precisa rodar onde o dado e a latência exigirem: no data center local, na borda (edge) ou em múltiplos provedores de nuvem, sempre ancorada em padrões abertos.
2. **Serviços de Dados (Data Fabric & Data as a Product):** O mantra dos autores é categórico: _sua inteligência artificial (AI) precisa de uma arquitetura de informação (IA)_. Sem um tecido de dados que unifique o acesso e trate dados como produtos com donos de domínio definidos, os modelos operam sobre silos desconectados.
3. **Plataforma de IA e Governança:** O motor central onde modelos abertos e proprietários são catalogados, ajustados e monitorados contra drift (desvio de acurácia) ao longo de todo o ciclo de vida.
4. **SDKs e APIs Padronizadas:** A interface limpa de consumo para desenvolvedores integrarem recursos de inteligência diretamente no software de produção.
5. **Agentes e Assistentes:** O topo da esteira, onde rotinas operacionais e atendimentos ganham autonomia para executar fluxos ponta a ponta.

Nos últimos 25 anos, os gastos globais com tecnologia saltaram de 5% para 15% do PIB mundial, com estimativas de atingir 25% a 35% na próxima década. Tratar essa arquitetura como um centro de custo a ser espremido em vez de um motor de produtividade é a certeza de perder relevância no mercado.

#### Equação 3: O Equilíbrio do Paradoxo

> Finding the Balance = Leadership + Skills + Open

A disrupção e a responsabilidade precisam coexistir. Uma liderança pragmática atua com postura de curadoria (_stewardship_), constrói um programa contínuo de requalificação de habilidades (_skills_) e ancora sua arquitetura em padrões abertos (_open source_) para evitar aprisionamento tecnológico (_vendor lock-in_).

---

### 3. Os Três Modos de Consumo: De Usuário a Criador

Como a sua organização consome inteligência artificial define diretamente a captura de valor e a sustentabilidade das margens:

{% include figure image_path="/assets/images/1_c0NK8DMXxvAjLGF1kNUYhA.png" %}

#### O Caso L’Oréal: A Linguagem da Beleza como Ativo Privado

A gigante de cosméticos L’Oréal compreendeu essa dinâmica ao se aproximar dos seus 120 anos de história. A empresa acumula décadas de dados de formulação química, testes de tolerância cutânea, ciência dos materiais e preferências regionais de consumo.

Se a L’Oréal optasse pela postura de AI User, despejaria esse tesouro em prompts de modelos comerciais, transferindo seu valor intelectual para bases proprietárias externas.

Em vez disso, a empresa adotou a postura de AI Value Creator: construiu modelos especializados internos para codificar a “linguagem da beleza”. Seus 4.000 pesquisadores utilizam modelos customizados rodando sobre infraestrutura privada para simular formulações moleculares, acelerar o desenvolvimento de produtos e garantir que o conhecimento proprietário permaneça blindado dentro de casa.

---

### 4. A Curva dos Casos de Uso e o Fim do “JOBOL” Legado

A maioria das empresas que tenta adotar IA generativa fica empacada no mesmo lugar: uma esteira infinita de testes isolados, resumos de PDF e protótipos de marketing que nunca chegam à produção.

{% include figure image_path="/assets/images/1_ROXF2-1bP41wjR8QTTKEIQ.png" %}

O pesadelo de JOBOL: quando modernizar 230 Bi de linhas de mainframe não é só copiar e colar COBOL do ChatGPT.

No Capítulo 4, os autores apresentam a Curva de Criação de Valor do Caso de Uso (_The Use Case Value Creation Curve_), mostrando a trajetória necessária para transformar curiosidade técnica em retorno econômico:

TRAJETÓRIA DE MATURAÇÃO DOS CASOS DE USO  
┌─────────────────────────────────────────────────────────────┐  
│ 1. Experimentação       │ Testes soltos com prompts         |  
|                         |                e modelos abertos. │  
│ 2. Dados Proprietários  │ RAG inicial e conexão             |  
|                         |               com manuais e docs. │  
├─────────────────────────┴───────────────────────────────────┤  
│ ===> PONTO DE INFLEXÃO DE VALOR (O SALTO DE ESCALA)         │  
├─────────────────────────────────────────────────────────────┤  
│ 3. Automação de TI      │ Gestão de certificados,           |  
|                         |           observabilidade e SRE.  │  
│ 4. Código e Engenharia  │ Modernização de legado,           |  
|                         |           testes e documentação.  │  
│ 5. Trabalho Digital     │ Assistentes que operam            |  
|                         |            tarefas ponta a ponta. │  
│ 6. Agentes Autônomos    │ Sistemas com ferramentas,         |   
|                         |               memória e loop.     │   
└─────────────────────────────────────────────────────────────┘ 

A virada de chave acontece quando a empresa cruza o Ponto de Inflexão de Valor: sair da perfumaria e colocar a IA para sustentar o próprio coração operacional da tecnologia.

#### O Caso da Automação de TI (IT Automation)

Antes de tentar reinventar a experiência do cliente, a maior alavanca de _Shift Left_ está dentro de casa. O livro cita o exemplo prosaico, mas devastador, da gestão de certificados digitais: certificados expirados em sistemas distribuídos são uma das principais causas de indisponibilidade severa e brechas de segurança em grandes empresas.

Automatizar rotinas de observabilidade, saneamento de certificados e aplicação de patches de segurança não é glamoroso, mas é onde reside o maior ROI imediato. Na iniciativa interna da IBM (_Client Zero_), a aplicação de IA na automação de TI alcançou:

- 80% dos principais incidentes de TI contidos e resolvidos automaticamente.
- Redução de 93% no tempo necessário para aplicar patches em servidores Linux (incluindo mitigações críticas como o _Dirty Pipe_ — CVE-2022–0847).
- Economia anualizada de US$ 165 milhões apenas na operação interna de tecnologia.

#### O Perigo do “JOBOL” na Modernização de Legado

Quando o assunto é código, o mercado frequentemente cai em uma armadilha perigosa. Estima-se que mais de **230 bilhões de linhas de código COBOL** continuem ativas no mundo, sustentando cerca de **US$ 3 trilhões em comércio diário** nos sistemas bancários e transacionais mais críticos do planeta.

Com a aposentadoria iminente dos engenheiros seniores (_Silver Tsunami_), as empresas entram em pânico e tentam o caminho mais ingênuo: despejar rotinas de COBOL em modelos generalistas como o ChatGPT e pedir para “traduzir para Java”.

O resultado é o que os autores apelidam de **“JOBOL”**: um monstro Frankenstein que compila com erros sutis, ignora dependências ocultas, perde a precisão decimal necessária para transações financeiras e cria um pesadelo de debug ainda mais caro que o código original.

A engenharia séria faz o inverso:

1. **Curar a Amnésia Corporativa:** Antes de gerar qualquer código novo, a IA deve ser usada para **mapear dependências e regras de negócio** (usando ferramentas como ADDI para destrinchar os monólitos).
2. **Modelos Especializados em Pares Validados:** Em vez de modelos generalistas, a modernização exige SLMs treinados especificamente sobre pares de código funcional corporativo (como o _Granite COBOL_ de 20B parâmetros), desenvolvidos por engenheiros bilíngues que garantem a equivalência semântica e testes unitários automatizados.

#### A Economia do Trabalho Digital (Digital Labor)

No atendimento e nos processos operacionais, a matemática de custos é brutal:

- Uma interação conduzida por um atendente humano em call center custa em média **US$ 5,00**.
- A mesma interação resolvida por um atendente digital baseado em IA e dados proprietários custa cerca de **US$ 0,25**.

No setor de varejo, a rede de franquias _Sport Clips_ reduziu o tempo de triagem e contato inicial de candidatos de 3 horas para 3 minutos usando assistentes digitais. O aplicativo da _Klarna_ virou o garoto-propaganda mais barulhento desse movimento ao anunciar que sua IA absorveu dois terços dos atendimentos no primeiro mês, equivalendo ao trabalho de 700 operadores em tempo integral.

No entanto, o caso Klarna também virou um estudo de caso sobre os perigos da euforia precipitada: o congelamento agressivo de contratações e o corte indiscriminado de equipes geraram forte atrito com clientes em disputas financeiras complexas e desgaste institucional. A empresa precisou flexibilizar o congelamento e reabrir contratações de engenharia e produto para sustentar o crescimento pré-IPO, provando que automatizar o atendimento de nível 1 não elimina a necessidade de manter humanos seniores no comando de casos críticos.

---

### 5. A Quebra do Monopólio dos Gigantes: A Era dos SLMs

Durante os primeiros anos da corrida de IA generativa, a indústria operou sob o dogma de que _“quanto maior o modelo, melhor o resultado”_. Entre o GPT-1 (117 milhões de parâmetros em 2018) e o GPT-4 (estimado em mais de 1 trilhão de parâmetros em uma arquitetura Mixture of Experts), o volume de parâmetros explodiu mais de dez mil vezes.

Essa abordagem de força bruta cobra um preço severo na ponta da inferência. Rodar modelos com centenas de bilhões de parâmetros em produção exige clusters de GPUs H100 que consomem megawatt-hora e geram custos de até US$ 60 por milhão de tokens de saída.

#### A Evolução das Leis de Escala: Da Força Bruta ao Test-Time Compute

Durante anos, a discussão sobre leis de escala se limitava à matemática de pré-treino: quantos tokens de texto bruto injetar para cada parâmetro da rede. Com a consolidação dos modelos de código aberto de alta densidade (Llama 3.1, Qwen 2.5), das arquiteturas MoE de granularidade fina (DeepSeek, GLM) e dos modelos de raciocínio, essa dinâmica se transformou em uma evolução de quatro fases bem definidas:

1. **A Era da Força Bruta (Kaplan / OpenAI, 2020):   
    Proporção:** cerca de 2 tokens para cada 1 parâmetro (ex: GPT-3 de 175B treinado em ~300 bilhões de tokens).   
    **Dogma:** acreditava-se que para deixar o modelo mais inteligente bastava aumentar a contagem bruta de parâmetros a qualquer custo.
2. **A Era Compute-Optimal (Chinchilla / DeepMind, 2022):  
    Proporção:** 20 tokens para cada 1 parâmetro (ex: Chinchilla de 70B treinado em 1,4 trilhão de tokens).  
    **Lição:** provou que os modelos gigantes da era anterior eram desproporcionais e drasticamente subtreinados para o orçamento computacional gasto.
3. **A Era Inference-Optimal / Over-Training (Llama 3, Qwen 2.5, 2023–2024):  
    Proporção:** saltou para 1.500:1 até mais de 2.000:1 (ex: Llama-3.1–8B treinado em 15 trilhões de tokens e Qwen-2.5–7B em 18 trilhões).  
    **Quebra do dogma:** treinar modelos pequenos por muito mais tempo compensa financeiramente. O custo de treino é pago uma única vez pelo fornecedor; o custo de inferência é pago a cada token gerado pela sua empresa.
4. **A Nova Fronteira: Sparsity Extrema e Test-Time Scaling (2025+):  
    Sparsity de granularidade fina (DeepSeek-V3, GLM-4, Qwen):** o modelo possui 671 bilhões de parâmetros no total, mas ativa apenas 37 bilhões por token (~5%). Centenas de microespecialistas são acionados de forma cirúrgica, entregando capacidade de meio trilhão de parâmetros com o custo de inferência e a velocidade de um modelo de 30B.  
    **Test-Time Compute (DeepSeek-R1, OpenAI o-series, Kimi k1.5)**: a escala migrou do pré-treino para o tempo de inferência. Dar espaço para o modelo gerar cadeias de pensamento (<think>), testar hipóteses e fazer backtracking via Reinforcement Learning permite que SLMs destilados de 7B a 14B superem modelos de 70B densos tradicionais.

Essa mudança redefine as prioridades da engenharia:

- **O Fim dos Modelos Densos Monolíticos:** Modelos onde 100% dos parâmetros disparam a cada token viraram um anacronismo de custo. Com arquiteturas esparsas adotadas por DeepSeek-V3 e GLM-4, ativam-se apenas frações cirúrgicas da rede, entregando a retenção de conhecimento de um modelo de meio trilhão de parâmetros com a fatura de inferência de um modelo de 30B.
- **Textbooks Are All You Need:** A série de modelos Phi da Microsoft (Phi-1, Phi-2 e Phi-4) comprovou que treinar SLMs com dados sintéticos estruturados e textos educativos de alto nível permite superar modelos 25 vezes maiores treinados com dados não filtrados da internet.
- **A “Segunda Lei de Escala” (Test-Time Compute):** Provada por modelos como o DeepSeek-R1 e OpenAI o1/o3, a nova fronteira de inteligência gasta poder computacional na resposta. Dar ao modelo espaço para “pensar” antes de cuspir o resultado substitui a necessidade de pré-treinar redes gigantescas para tarefas de raciocínio, lógica e código.
- **Especialização Cirúrgica de Domínio:** O modelo **BioMedLM** (Stanford, 2,7B parâmetros), treinado exclusivamente em literatura biomédica, superou em 6% o gigante generalista **Galactica** (Meta, 120B parâmetros) em exames médicos do USMLE. Da mesma forma, o **Granite COBOL** (IBM, 20B parâmetros), treinado em código corporativo privado, superou o ChatGPT em geração e refatoração de COBOL no benchmark CodeNet.

---

### 6. Roteamento de Modelos e Mixture of Experts (MoE)

Uma organização madura não adota um único modelo universal. Um marceneiro não constrói um armário usando apenas um martelo; ele utiliza um cinto de ferramentas especializadas.

#### Model Routing: Orquestração Inteligente de Custos

Um dos avanços mais pragmáticos em arquitetura corporativa é o **Roteamento de Modelos** (_Model Routing_). Em vez de enviar todas as requisições para o modelo mais caro e pesado, um classificador leve avalia a complexidade do prompt e direciona a carga de trabalho para a ferramenta ideal.

                                 ┌───────────────────────────────┐  
                                 │      SLM Especializado        │  
                     ┌─── 10% ──>│   (3B-7B Params / Baixo Custo)│  
                     │           └───────────────────────────────┘  
┌─────────────┐  ┌───┴─────────┐ ┌───────────────────────────────┐  
│  Requisição │─>│ AI Router   │─┼─── 34% ──>│   Modelo Médio    │  
│ (User Prompt│  │(Classifica) │ │           │   (11B-40B Params)│  
└─────────────┘  └───┬─────────┘ └───────────────────────────────┘  
                      │          ┌───────────────────────────────┐  
                      └── 56% ──>│     Modelo de Fronteira       │  
                                 │   (70B+ Params / Raciocínio)  │  
                                 └───────────────────────────────┘

Em estudos conduzidos pelo _MIT-IBM Watson AI Lab_ utilizando a suíte de avaliação HELM de Stanford:

- O modelo Llama-2–70B sozinho atingiu **68% de acurácia média**.
- Com a introdução de um roteador sobre uma biblioteca mista de modelos (pequenos, médios e o próprio 70B), a acurácia subiu para **72%**, com **apenas 56% das requisições sendo direcionadas ao modelo grande**.
- Ao restringir a biblioteca exclusivamente a **SLMs com até 13B parâmetros**, a acurácia atingiu **70%** — superando o modelo de 70B isolado, reduzindo a latência média e dispensando infraestrutura pesada de GPUs de ponta.

#### Mixture of Experts (MoE) e o “Fenômeno DeepSeek”

Enquanto o roteamento de modelos ocorre no nível do software, a arquitetura **Mixture of Experts (MoE)** aplica o mesmo princípio internamente na rede neural.

Em modelos densos tradicionais, todos os bilhões de parâmetros são ativados para cada token processado. Em um modelo MoE, os parâmetros são distribuídos em “especialistas” e um roteador interno ativa apenas um subconjunto por token:

- **Mixtral 8x7B:** Possui 47 bilhões de parâmetros no total, mas ativa apenas 2 especialistas por token (14 bilhões de parâmetros ativos), entregando velocidade e consumo de memória equivalentes a um modelo muito menor.
- **Granite-3.0–1B-A800M:** Possui 1 bilhão de parâmetros brutos, mas roda com apenas 800 milhões de parâmetros ativos na inferência.
- **DeepSeek-R1 / V3:** Opera com 671 bilhões de parâmetros totais, mas ativa apenas 37 bilhões por token durante a geração.

O livro faz um alerta importante sobre o ruído da imprensa em relação ao custo reportado de **US$ 5,6 milhões** para o treino do DeepSeek-V3: esse valor cobre estritamente a rodada final de treinamento do modelo base. Não inclui a montanha de pesquisas prévias, testes de arquitetura e centenas de experimentos de ablação, que costumam custar facilmente dez vezes mais.

Ainda assim, o verdadeiro legado do DeepSeek-R1 não foi o custo do treino bruto, mas sim atuar como um **modelo professor aberto**. Usando suas 800 mil amostras de raciocínio lógico em matemática e código, a comunidade gerou os modelos _DeepSeek-R1-Distill_ sobre bases abertas (Llama e Qwen). Em menos de trinta dias, mais de 400 datasets derivados surgiram no Hugging Face.

Isso quebrou uma das maiores amarras do ecossistema: termos de serviço de provedores fechados (como OpenAI) proíbem explicitamente que seus modelos sejam usados para destilar ou treinar modelos concorrentes. Com professores abertos, a destilação de raciocínio virou patrimônio comunitário.

---

### 7. Dados Proprietários: Adeus ao “Rebanho de Forks” com InstructLab

Para injetar o conhecimento privado da sua empresa em um modelo de fundação, a engenharia dispõe de três caminhos clássicos:

{% include figure image_path="/assets/images/1_s5l7J_KogKxz883Ur-5nyA.png" %}

SLMs: modelos pequenos calibrados com dados proprietários, rodando com margem previsível e sem depender de terceiros.

1. **RAG (Retrieval-Augmented Generation):** O modelo consulta uma base vetorial externa e recebe o contexto no prompt em tempo de execução. Excelente para informações voláteis (ex: manuais de RH ou tabelas de preços que mudam semanalmente). _Limitação:_ Não ensina novas habilidades ao modelo e encarece a inferência com janelas de contexto gigantescas repetidas a cada chamada.
2. **Fine-Tuning Tradicional (SFT / LoRA):** Ajusta os pesos de adaptadores externos. _Limitação:_ Sofre com o **esquecimento catastrófico** (_catastrophic forgetting_), onde o modelo perde capacidades generalistas anteriores ao se hiperespecializar em uma tarefa. Além disso, manter 50 adaptadores LoRA diferentes em produção cria um inferno de manutenção.
3. **InstructLab (Large-Scale Alignment for ChatBots — LAB):** Metodologia de código aberto criada pela Red Hat e IBM para alinhar modelos de forma incremental e colaborativa.

#### A Metáfora do Copo Opaco: Onde você coloca seu limão e açúcar?

O livro recorre a uma analogia cristalina: imagine que alguém lhe entrega um copo de água totalmente opaco, cuja procedência você desconhece. Você não sabe se aquela água veio de uma nascente límpida ou de uma poça contaminada. Você colocaria suas melhores frutas e açúcar orgânico ali dentro para fazer uma limonada? Jamais.

Com IA corporativa acontece o mesmo. Se você faz fine-tuning dos seus dados proprietários mais estratégicos em cima de modelos fechados e opacos, cujos dados de pré-treino você desconhece (muitas vezes raspados de datasets pirateados como o _Books3_), você contamina sua limonada com passivos jurídicos, vieses ocultos e falta de reprodutibilidade. É por isso que famílias de modelos como o **IBM Granite** publicam abertamente a linhagem completa dos seus dados de treino sob licença permissiva Apache 2.0: você precisa de um copo transparente antes de misturar o seu conhecimento de negócio.

FLUXO DE ALINHAMENTO INCREMENTAL COM INSTRUCTLAB  
┌────────────────┐    ┌──────────────────┐    ┌──────────────────┐  
│ Taxonomia YAML │    │ Geração Sintética│    │ Validação Crítica│  
│ (5+ Exemplos   │───>│ (Teacher Model   │───>│ (Modelos Juízes  │  
│ Handcrafted)   │    │  Mixtral-Instruct│    │  Filtram Ruído)  │  
└────────────────┘    └──────────────────┘    └──────────────────┘  
                                                        │  
                                                        ▼  
┌────────────────┐    ┌──────────────────┐    ┌──────────────────┐  
│ Modelo Starter │    │ Treinamento Fases│    │ Novo Build do    │  
│ (Granite /     │<───│ (Mescla Sintético│<───│ Modelo Alinhado  │  
│  Llama Open)   │    │  com Base Preven)│    │ (Sem Forks)      │  
└────────────────┘    └──────────────────┘    └──────────────────┘

O InstructLab resolve o problema do “rebanho de forks” permitindo que especialistas de negócio e desenvolvedores submetam habilidades e conhecimentos em arquivos YAML estruturados via Pull Requests no GitHub:

- **Geração Sintética de Alta Qualidade:** Um modelo professor aberto (como o Mixtral-Instruct) expande os 5 exemplos iniciais em milhares de pares pergunta/resposta instrucionais.
- **Filtros de Qualidade e Crítica:** Modelos avaliadores barram exemplos incoerentes ou tóxicos.
- **Mitigação do Esquecimento Catastrófico:** O pipeline de treinamento mescla os novos dados gerados com amostras do dataset de treino original, preservando a capacidade de raciocínio geral enquanto absorve o conhecimento corporativo.

---

### 8. Cicatrizes de Produção: Segurança, Governança e Armadilhas

Colocar IA em produção corporativa sem uma camada ativa de governança é assumir passivos jurídicos e operacionais desproporcionais. O livro detalha casos emblemáticos que servem de alerta:

#### 1. Alucinações com Responsabilidade Jurídica

- **Mata v. Avianca:** Advogados utilizaram o ChatGPT para elaborar uma petição e apresentaram jurisprudências e citações de juízes inteiramente inventadas pelo modelo. Acabaram multados e sancionados pelo tribunal por falta de diligência elementar.
- **Air Canada:** O chatbot de atendimento ao cliente alucinou uma política inexistente de desconto de passagens em caso de luto. O cliente comprou o bilhete esperando o reembolso posterior e a companhia negou o valor. O tribunal canadense decidiu que **a empresa é legalmente responsável pelas promessas feitas pelo seu modelo de IA**, rejeitando a alegação da companhia aérea de que o chatbot era _“uma entidade separada e responsável pelos seus próprios atos”_.

{% include figure image_path="/assets/images/1_-Hjrh20IJJ-sHrh7ybMHTg.png" %}

O caso Air Canada: a empresa alegou que o chatbot era ‘uma entidade separada’, mas o tribunal lembrou que a fatura do processo ainda é do CNPJ

#### 2. A Superfície de Ataque Expandida

- **Envenenamento de Dados (_Data Poisoning_):** Ferramentas como o _Nightshade_ aplicam alterações imperceptíveis aos olhos humanos nos pixels de imagens, mas induzem modelos de visão a confundir carros com árvores ou lesões malignas de pele com manchas benignas.
- **Ataques de Injeção de Prompt via Formatos Ricos:** No teste com o candidato fictício _John Stikava_, os autores inseriram termos-chave (como _“veterano”_, _“neurodivergente”_, _“condecoração militar”_) em fonte branca dentro do código XML de um documento Word (.docx). Os recrutadores humanos viam um currículo comum; os algoritmos de triagem baseados em XML leram as palavras invisíveis e classificaram o candidato com nota máxima, gerando convites imediatos para entrevistas.
- **Jailbreak por Arte ASCII (_ArtPrompt_):** Modelos alinhados para recusar instruções perigosas podem ser burlados quando a palavra proibida é desenhada em arte ASCII (ex: `B-O-M-B` em caracteres de texto), pois o modelo processa os caracteres individualmente sem acionar os filtros semânticos de entrada.
- **Engenharia Social com Deepfakes:** Uma multinacional em Hong Kong sofreu um prejuízo de US$ 25 milhões após um analista financeiro participar de uma chamada de videoconferência onde todos os demais participantes — incluindo o Diretor Financeiro (CFO) — eram réplicas geradas por deepfakes em tempo real.

#### Os Quatro Pilares da Governança Ativa

Para blindar a operação, os autores estabelecem quatro alavancas mandatórias:

1. **Fairness (Equidade):** Monitoramento contínuo de métricas de disparidade estatística em decisões automatizadas (ex: concessão de crédito, triagem de talentos).
2. **Robustness (Robustez):** Uso de modelos de proteção em tempo real como o **Granite Guardian** e o **Llama Guard**, que inspecionam entradas e saídas antes que cheguem ao usuário ou ao sistema interno.
3. **Explainability (Explicabilidade):** Aplicação de técnicas de interpretabilidade (SHAP, LIME e mapeamento de ativações neurais) para justificar decisões críticas a órgãos reguladores (conforme exigido pelo Artigo 14 da GDPR e pelo _EU AI Act_).
4. **Lineage (Linhagem):** Rastreabilidade completa da origem de cada dataset, licença de uso e versão dos pesos, similar ao selo de inspeção nutricional da indústria de alimentos.

### 9. Cultura e Habilidades: As 8 Alavancas da Sabedoria

A tecnologia é a parte mais previsível da transformação; o gargalo crítico reside na capacitação e na cultura organizacional.

#### O Paradoxo dos Caixas Eletrônicos (ATMs) e o Xadrez Centauro

O medo de que a IA elimine postos de trabalho de forma generalizada esbarra em precedentes históricos claros. Quando os caixas eletrônicos (ATMs) foram introduzidos nos anos 1970, previa-se o fim dos caixas bancários humanos.

O que ocorreu nas quatro décadas seguintes foi o oposto: o custo de operação de cada agência despencou, os bancos abriram milhares de novas filiais e o número total de caixas bancários aumentou. As tarefas repetitivas (contar cédulas) foram absorvidas pelas máquinas, liberando os humanos para consultoria financeira, vendas complexas e gestão de relacionamento.

O mesmo princípio fundamenta o **Xadrez Centauro**, criado por Garry Kasparov após a derrota para o Deep Blue em 1997:

> Humano Mediano + Máquina + Processo Superior > Humano Excepcional Isolado

#### A Taxonomia de 5 Níveis Auditáveis

Para estruturar um programa corporativo de habilidades sem cair na armadilha de autoavaliações subjetivas (_“é como pedir para o gato avaliar sua habilidade de caçar”_), a IBM adotou uma taxonomia baseada em **verbos de ação verificáveis**:

ESTRUTURA DE MATURIDADE DE HABILIDADES TÉCNICAS  
┌──────────────────────────────────────────────────────────────┐  
│ Lvl 1: FRAME     │ Enquadrar a dor de negócio do cliente.    │  
│ Lvl 2: CHALLENGE │ Mapear a arquitetura técnica da solução.  │  
│ Lvl 3: DEMO      │ Executar demonstração AO VIVO             |  
|                  |                      (sem slides de PPT). │  
│ Lvl 4: DEPLOY    │ Pilotar e subir a solução em produção     |  
|                  |                              (Dia 0/1/2). │  
│ Lvl 5: TEACH     │ Produzir material técnico, artigos e      |  
|                  |                             formar times. │  
└──────────────────────────────────────────────────────────────┘

No caso de estudo do **Watsonx Corporate Skills Challenge**, a IBM engajou voluntariamente ~160.000 funcionários (60% da força de trabalho global), organizados em mais de 30.000 equipes. O resultado foram 12.000 protótipos funcionais submetidos. Em um dos projetos vencedores, engenheiros de confiabilidade de sites (SREs) que gastavam 116 horas semanais respondendo a dúvidas rotineiras de desenvolvimento reduziram esse tempo para **menos de 2 minutos por chamado, atingindo 99,98% de deflexão** com busca semântica sobre a base de conhecimento interno.

---

### 10. O Horizonte da Computação Generativa e Hardware Dedicado

O último ato de _AI Value Creators_ aponta para a maturidade da ciência da computação: a consolidação da **Computação Generativa** ao lado da computação clássica (Bits) e da computação quântica (Qubits).

### O Fim do “Prompt Engineering” Artesanal

Atualmente, engenheiros interagem com LLMs utilizando textos livres quilométricos (_mega-prompts_). Esse processo se assemelha a tapar buracos no asfalto após o inverno: para cada falha de formato ou segurança, cola-se mais um parágrafo de instruções (_“por favor, responda em JSON”_, _“não mencione concorrentes”_).

{% include figure image_path="/assets/images/1_Y8TmbZk0X70ru-bRmcQRgQ.png" %}

A barreira de David Clark: você pode comprar mais GPUs para aumentar vazão, mas para cortar latência em cadeias de raciocínio, a velocidade da luz é fixa.

A Computação Generativa substitui essa fragilidade por **Runtimes Inteligentes**:

- **Controle de Fluxo Programático:** Interfaces estruturadas onde restrições de formato, segurança e chamadas de ferramentas são definidas no nível da API e do compilador, e não em texto livre.
- **Funções Intrínsecas (_Intrinsics_):** Capacidades embutidas diretamente no modelo durante o treinamento. Por exemplo, o método **Thermometer** permite que o próprio modelo inspecione suas ativações neurais internas e emita tokens de confiança; caso a pontuação seja baixa, o runtime dispara uma exceção de software tratada nativamente pelo código da aplicação.
- **Gestão Avançada de Memória:** Otimização de buffers e reaproveitamento estruturado do cache de Chaves/Valores (KV Cache), eliminando a reavaliação redundante de tokens de contexto.

#### Hardware Neuromórfico e a Lei de David Clark

Com a consolidação de modelos de raciocínio (_reasoning_ como a série o da OpenAI e o DeepSeek-R1), a computação migra do tempo de treino para o **tempo de inferência** (_Inference-Time Compute_). O modelo não cospe a primeira resposta: ele gera árvores de raciocínio, avalia alternativas e retrocede se atingir um beco sem saída lógico (_checkpoint reasoning_).

Só que isso esbarra em uma restrição física brutal, sintetizada na famosa frase do cientista da computação David Clark:

> *“Throughput problems can be cured with money. Latency problems are harder because the speed of light is fixed — you can’t bribe God.”*
> 
> *(Problemas de vazão você resolve com dinheiro. Problemas de latência são mais difíceis porque a velocidade da luz é fixa — você não pode subornar Deus).*

Em tarefas de raciocínio sequencial com dependências estritas, comprar mais GPUs não reduz a latência de uma cadeia de pensamento individual. A arquitetura clássica de von Neumann quebra porque precisa trafegar bilhões de parâmetros constantemente entre a memória externa (HBM/DRAM) e os núcleos de computação da GPU através do barramento.

Para superar essa barreira, a indústria precisa de hardware construído sob medida para a computação generativa. O chip **IBM NorthPole** adota uma arquitetura inspirada no cérebro humano (_non-von Neumann_), integrando processamento e memória exatamente no mesmo espaço físico de silício:

- **Zero Memória Externa:** Elimina o gargalo de barramento mantendo os pesos inteiramente residentes nos nós de computação para modelos de até 3 bilhões de parâmetros.
- **Matemática Inteira em 4 bits:** Quantização nativa ultraeficiente.
- **Eficiência Radical:** Em benchmarks de inferência de linguagem, o NorthPole entregou **72,7 vezes mais eficiência energética** (tokens por segundo por watt) e custo **47 vezes menor** (tokens por dólar) do que as GPUs H100 tradicionais de mercado, com **latência 2,5 vezes menor**.

---

### Conclusão: O Mapa de Navegação para o Líder Técnico

Tornar-se um **AI Value Creator** não é uma questão de comprar licenças mais caras ou esperar pelo próximo lançamento de modelo de trilhões de parâmetros. É uma decisão deliberada de arquitetura, cultura e governança:

1. **Classifique o Orçamento:** Determine com clareza se a iniciativa foca em _Renovação_ (economizar custos via automação interna) ou _Inovação_ (gerar receita com novos modelos de negócio).
2. **Comece por Baixo Risco (Shift Left):** Automatize fluxos internos e rotinas operacionais antes de expor modelos a clientes finais.
3. **Seus Dados São o Fosso:** Não entregue seus diferenciais corporativos para enriquecer modelos de terceiros. Use RAG para contexto dinâmico e InstructLab para absorver know-how permanente.
4. **Construa um Cinto de Ferramentas:** Combine SLMs eficientes ( menor que 13B ) com roteamento inteligente de modelos e arquiteturas MoE.
5. **Governe Ativamente:** Exija transparência de dados de treino, monitore desvios de acurácia (_drift_) e implemente guardrails em tempo real.
6. **Capacite com Rigor:** Troque autoavaliações por demonstrações ao vivo e valorize a curiosidade e o aprendizado contínuo.

Como pontuam Rob Thomas, Paul Zikopoulos e Kate Soule: a tecnologia não é mágica, é matemática e engenharia. O valor que você extrai dela dependerá exclusivamente do método com que você a constrói.

---

### Referências Bibliográficas e Leituras Recomendadas

1. **Thomas, R., Zikopoulos, P., & Soule, K. (2025).** _AI Value Creators: Beyond the Generative AI User Mindset_. O’Reilly Media.
2. **Gunasekar, S. et al. (2023).** _Textbooks Are All You Need_. Microsoft Research.
3. **Hoffmann, J. et al. (2022).** _Training Compute-Optimal Large Language Models (Chinchilla Paper)_. DeepMind.
4. **Sudalairaj, S. et al. (2024).** _LAB: Large-Scale Alignment for ChatBots_. Red Hat & IBM Research.
5. **Appuswamy, R. et al. (2024).** _Breakthrough Low-Latency, High-Energy-Efficiency LLM Inference Performance Using NorthPole_. IBM Research.
6. **McAfee, A. (2023).** _The Geek Way: The Radical New Approach that Will Transform Shaping the Future of Business_. Little, Brown.
7. **Bessen, J. (2015).** _To Be an ATM: How Technology Affects Employment_. Boston University School of Law.
8. **Jiang, F. et al. (2024).** _ArtPrompt: ASCII Art-Based Jailbreak Attacks Against Aligned LLMs_. arXiv.

---

**E na sua Empresa:** o time ainda corre na esteira do pagamento de assinatura de API ou já começou a desenhar a própria esteira soberana de SLMs e dados proprietários? Deixe seu comentário ou me add pra trocarmos uma ideia:

- **GitHub:** [@maiquelleonel](https://github.com/maiquelleonel)
- **LinkedIn:** [/in/maiquelleonel](https://www.linkedin.com/in/maiquelleonel)

