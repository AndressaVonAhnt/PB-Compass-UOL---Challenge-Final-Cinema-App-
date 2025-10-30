
# 🎬 Cinema App: Projeto de Automação de Testes (QA Challenge)

## 🌟 Visão Geral do Projeto

Este Plano de Testes descreve a estratégia, o escopo e as abordagens de Garantia da Qualidade (QA) aplicadas à aplicação Cinema App, que é composta por um *Backend* (API RESTful) e um *Frontend* (Web React).

A automação foi implementada utilizando o **Robot Framework**, aplicando os padrões de design **Page Objects** (para o Frontend) e **Service Objects** (para o Backend) para garantir a reutilização, manutenibilidade e escalabilidade do código.

| 📅 Data | ✍️ Autora |
| ----- | ----- |
| 31/10/2025 | Andressa Von Ahnt |

## 🛠️ Tecnologias Utilizadas

| Componente | Tecnologia | Uso |
| ----- | ----- | ----- |
| **Framework de Automação** | Robot Framework | Base para a criação dos *test cases*. |
| **Testes de API (*Backend*)** | RequestsLibrary | Validações funcionais, códigos de *status* e integridade de dados na API. |
| **Testes E2E (*Frontend*)** | BrowserLibrary (Playwright) | Simulação do fluxo do usuário (*End-to-End*) na interface web (UI/UX). |
| **Padrões de Design** | Service Objects e Page Objects | Reutilização e manutenibilidade do código. |

## 📐 Estrutura do Projeto

O projeto segue uma estrutura modular, conforme as boas práticas de automação, separando os testes por camada (API e Web) e utilizando o diretório `resources` para os padrões de design:

```

📂 automation
├── 📂 api_tests                 # Testes Funcionais da API (Service Objects)
│   ├── admin_security_tests.robot
│   ├── auth_tests.robot
│   ├── movie_tests.robot
│   ├── reservation_tests.robot
│   └── theater_session_tests.robot
├── 📂 resources                 # Componentes Reutilizáveis
│   ├── 📂 PageObjects           # Padrão Page Objects (E2E Frontend)
│   │   ├── ...                  # Cada página da aplicação
│   ├── ServiceObjects            # Padrão Service Objects (API Backend)
├── base.resource           # Variáveis globais (URLs, credenciais)
├── 📂 web_tests                 # Testes Funcionais/E2E do Frontend (Page Objects)
│   ├── admin_tests.robot
│   ├── homepage_tests.robot
│   ├── login_tests.robot
│   ├── movie_tests.robot
│   ├── payment_tests.robot
│   ├── profile_tests.robot
│   ├── reserves_tests.robot
│   ├── seats_tests.robot
│   └── signup_tests.robot
📂 docs                      # Documentação
├── Plano_de_Teste.pdf       # Documento base para a automação
├── Mapa_Mental.png
└── Relatório de Issues

````

### Padrões e Boas Práticas

* **Service Objects (API):** Encapsula chamadas HTTP e validações de API, aplicado para o *Backend* na pasta `api_tests`.

* **Page Objects (E2E/Web):** Isola elementos de interface (seletores) e ações por página, utilizado para o *Frontend* na pasta `web_tests`.

* **Cenários Independentes:** Cada *Test Case* é projetado para ser executado de forma isolada, garantindo a robustez da automação.

## 🌐 Configuração da Aplicação Alvo (Cinema App)

Para que os testes de automação possam ser executados, é **obrigatório** que as aplicações Backend e Frontend do Cinema App estejam rodando localmente.

### Pré-requisitos da Aplicação

* **MongoDB:** Instância local ou conexão remota configurada.

* **Node.js** e **npm** (Para a execução de ambos os projetos).

### Passos para Inicialização da Aplicação

### Backend (API)

A API requer a configuração de variáveis de ambiente no arquivo `.env` para conectar ao banco de dados e garantir o funcionamento da autenticação.

1.  **Clonar o Repositório:**
```bash
git clone https://github.com/juniorschmitz/cinema-challenge-back.git cinema-back
cd cinema-back
````

2.  **Configuração do Arquivo `.env` (Exemplo para Testes):**
    Crie o arquivo `.env` na raiz do projeto `cinema-back` com as seguintes variáveis.
    *A chave `JWT_SECRET` é crucial para os testes de login e segurança (R1/R5).*


```plaintext
PORT=3000
MONGODB_URI=mongodb://localhost:27017/cinema-app
JWT_SECRET=minha_chave_secreta_super_segura_para_testes 
```

3.  **Instalar e Iniciar:**

```bash
# Instale o Docker ou o MongoDB localmente e configure a conexão
npm install
npm start # Inicia a API. Deve rodar em http://localhost:3000 (Verifique a porta padrão no log do console)
```

4. **Preenchimento Inicial do Banco de Dados:** Para garantir que os testes de Autenticação, Filmes e Reservas funcionem corretamente, é obrigatório preencher o banco de dados com dados iniciais (usuários de teste e filmes).
```bash
# Execute os seguintes comandos no terminal, a partir da pasta raiz do projeto Backend (cinema-challenge-back):
# Navegar para a raiz do projeto (caminho de exemplo)
cd c:\Users\jacques.schmitz\Desktop\new-cinema-fixes\cinema-challenge-back

# Executar scripts para criar usuários e filmes
node src/utils/setup-movies-db.js
node src/utils/setup-test-users.js
node src/utils/seedMoreMovies.js
```
    ⚠️ NOTA IMPORTANTE sobre Sessões e Teatros

    Para testar rotas que dependem de agendamentos (GET /sessions, POST /sessions) ou reservas, como o fluxo E2E de reserva, é necessário que Teatros e Sessões existam no banco de dados.

    Como esses dados não são gerados pelos scripts acima, eles devem ser criados manualmente (usando fixtures) através dos endpoints de Administração (CRUD) da API (CT-ADMIN-034 e CT-ADMIN-057 no arquivo /api_tests/admin_security_tests.robot, sendo primeiro a criação de pelo menos um Teatro e, depois, a criação da Sessão), antes de executar os testes de Reserva.

<!-- end list -->

### Frontend (Web - React)

```bash
git clone https://github.com/juniorschmitz/cinema-challenge-front.git cinema-front
cd cinema-front
# Certifique-se de que a variável de ambiente para a API (BASE_URL) aponta corretamente para o Backend em http://localhost:3002
npm install
npm start # Inicia o Frontend. Deve rodar em http://localhost:3002
```

## 🚀 Como Configurar e Executar o Projeto (Automação)

### Pré-requisitos

1.  **Python 3.x**

2.  **pip** (gerenciador de pacotes do Python)

3.  **Navegador** (A BrowserLibrary requer a instalação dos *drivers* do Playwright).

### 1\. Clonar o Repositório (Projeto de Automação)

```bash
git clone https://github.com/AndressaVonAhnt/PB-Compass-UOL---Challenge-Final-Cinema-App- challenge-final
cd challenge-final
```

### 2\. Ajuste de Configuração Crítica

**IMPORTANTE:** Antes de executar os testes, verifique a porta de inicialização da API do Backend (Passo 1 da seção anterior). Se a porta for diferente de `3000`, você **DEVE** alterar a variável de URL base no arquivo `resources/base.resource` para corresponder à porta retornada pelo *backend*. A mesma coisa deve ser feita para o Frontend, a porta deve ser `3002`, se não for esta porta, altere no arquivo `resources/base.resource`.

### 3\. Instalar Dependências

Instale o Robot Framework e as bibliotecas necessárias através do `requirements.txt`:

```bash
pip install -r requirements.txt
```

Instale os *drivers* do Playwright:

```bash
python -m playwright install
```

### 4\. Executar os Testes

Para rodar todos os testes (API e E2E):

```bash
robot automation/
```

Para executar testes de uma camada específica (Ex: Somente a camada Frontend/Web):

```bash
robot automation/web_tests/
```

Para rodar uma *suite case*:

```bash
robot automation/web_tests/reserves_tests.robot
```

*Após a execução, os relatórios (`log.html` e `report.html`) serão gerados na pasta principal do projeto.*

## 📝 Análise e Planejamento (Foco nos Pontos Avaliativos)

O planejamento de testes foi detalhado no documento **"Plano de Testes - Cinema App.pdf"**, seguindo as etapas de Análise de Risco e Priorização.

### Cenários Criados e Cobertura

Foram criados **74 cenários de teste** (de `CT-AUTH-001` a `CT-SESSION-074`) cobrindo os módulos críticos: Autenticação, Filmes/Sessões, Reserva e Administração. Os cenários buscam a cobertura completa dos **Critérios de Aceitação (C.A.)** das User Stories e as funcionalidades da aplicação. Incluem testes do tipo:

  * **Happy Path** (Fluxos de sucesso, ex: `CT-AUTH-001`).

  * **Negativo** (Validação de erros e integridade, ex: `CT-RESERVE-037: Assento já reservado`).

  * **Teste de Fronteira** (Valores Limites, ex: `CT-AUTH-011: Senha no comprimento mínimo`).

  * **Segurança/Autorização** (Rotas protegidas/Admin, ex: `CT-ADMIN-053: Tentar Criar Filme como Usuário Comum`).

Ao total, foram testados 24 cenários de teste do Backend e 27 cenários do Frontend.

### Priorização e Matriz de Risco

A priorização foi definida com base no impacto da funcionalidade no fluxo de receita (P1) e nos riscos críticos identificados (R1, R2, R5).

| Prioridade | Módulos Focados (Exemplos) | Meta de Cobertura |
| ----- | ----- | ----- |
| **P1 - Crítica** | Login, Fluxo E2E Completo de Reserva, Segurança Admin. | 100% dos C.A. de P1 cobertos. |
| **P2 - Alta** | Validação de Assento Indisponível, CRUD de Filmes. | 100% dos cenários P2 automatizados. |

Além disso, outros testes foram realizados, como CRUD dos endpoints, navegação das páginas, conteúdos das páginas, etc.

### Issues Abertas

Durante a análise e execução dos testes, as seguintes *Issues* foram abertas para registro de bugs e melhorias (Verificar o relatório de *Issues* no GitHub para detalhes):

  * **[BUG-001]:** Login com credenciais inválidas não exibe mensagem de erro ao usuário.
  * **[BUG-002]:** Botão 'Liberar Assentos' limpa a seleção de todos os assentos, incluindo os já reservados por outros usuários.
  * **[BUG-003]:** Rota de Checkout (/checkout) é acessível a Usuários Visitantes (Não Logados).
  * **[BUG-004]:** Não é possível selecionar a opção de Meia Entrada; sistema assume valor de Ingresso Inteiro.
  * **[BUG-005]:** Acesso à página de Administração (/admin) retorna 404 Not Found.
  * **[BUG-006]:** Falha de Sessão: Usuário recém-registrado é deslogado ao navegar para 'Minhas Reservas' ou 'Perfil'.

## 🧠 Adicional de Inovação: Geração de *Prompt* (GenAI)

Para demonstrar o uso de Inteligência Artificial Generativa (GenAI) na evolução do plano de testes, foi criado um *prompt* para refinar e expandir a cobertura de cenários críticos.

### O *Prompt*

```
"Considerando o Plano de Testes - Cinema App e os 74 cenários de teste já criados (focados em Autenticação, Reserva, Filmes e Administração), utilize sua expertise em QA para sugerir a adição de 3 novos cenários de teste de alta prioridade (P1/P2) para cada um dos seguintes focos, justificando a escolha e indicando a camada (API ou E2E) e o foco/tipo de teste:
1. Regras de Negócio Críticas (Ex: Prevenção de Fraude / Concorrência).
2. Acessibilidade / UX (Pontos Críticos fora do escopo inicial).
3. Robustez da API (Ex: Teste de Injeção de Dados/Payloads malformados).
Por fim, sugira uma melhoria ou ajuste na Matriz de Risco ou na Priorização da Execução."
```

## 🧑‍💻 Autoria

  * **Nome:** Andressa Von Ahnt
  * **Idade:** 22 anos
  * **Curso:** Ciência da Computação
  * **Semestre:** 5º Semestre
  * **Universidade:** Universidade Federal de Pelotas
  * **Cidade:** Pelotas/RS