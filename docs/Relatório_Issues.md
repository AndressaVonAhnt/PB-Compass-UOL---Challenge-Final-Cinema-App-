## 🐞 Relatório de Issues e Bugs - Cinema App

Este relatório consolida os bugs críticos e de alto impacto encontrados no sistema **Cinema App** (Frontend e Backend), conforme a análise de teste e o Plano de Testes.

| ID Issue | Título | Categoria | Impacto | Prioridade (Plano) | Cenário Relacionado |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **BUG-001** | Login com Credenciais Inválidas não Exibe Mensagem de Erro | UX/Autenticação | Alto | P1 - Crítica | CT-AUTH-005 |
| **BUG-002** | Botão 'Liberar Assentos' Limpa Assentos já Reservados | Integridade de Dados / Segurança | Máximo | P1 - Crítica | Afeta CT-RESERVE-037 |
| **BUG-003** | Falha de Regra de Negócio: Não é Possível Selecionar Meia Entrada | Regra de Negócio / Lógica de Cálculo | Alto | P2 - Alta | CT-RESERVE-040 |
| **BUG-004** | Rota de Checkout (/checkout) é Acessível a Visitantes (Não Logados) | Segurança / Controle de Rota | Máximo | P1 - Crítica | Afeta CT-AUTH-006 |
| **BUG-005** | Acesso à Página de Administração (/admin) Retorna 404 Not Found | Funcionalidade / Roteamento | Máximo | P1 - Crítica | Afeta CT-ADMIN-053 |
| **BUG-006** | Falha de Persistência de Sessão: Usuário Recém-Registrado é Deslogado | Sessão / UX | Alto | P3 - Média | CT-AUTH-006 |

---

### **1. [BUG-001] Login com Credenciais Inválidas não Exibe Mensagem de Erro ao Usuário**

* **Pré-condições:**
    * Ambiente: Frontend (Web React) rodando em `http://localhost:3002/login`.
    * Cenário Relacionado: `CT-AUTH-005` (Tentativa de Login com credenciais inválidas).
    * API Esperada: A API de Backend retorna o status `401 Unauthorized` para credenciais inválidas.
* **Passos para Reprodução:** Acessar a página de Login, preencher E-mail (válido) e Senha (incorreta/inexistente), e clicar em "Entrar".
* **Comportamento Esperado:** O Frontend deve capturar a mensagem de erro da resposta `401 Unauthorized` e exibi-la visualmente ao usuário na tela (Ex: banner de alerta ou texto de erro).
* **Comportamento Atual:** O Frontend permanece na página, mas **nenhuma mensagem de erro visual é exibida ao usuário**. O erro é visível apenas no Console do Navegador.
* **Impacto:** Alto Impacto na UX. O usuário fica preso em um *loop* de login sem *feedback*.

---

### **2. [BUG-002] Falha Crítica de Concorrência/Segurança: Botão 'Liberar Assentos' Limpa Assentos já Reservados**

* **Pré-condições:**
    * Ambiente de Teste: Página de Seleção de Assentos (E2E).
    * Dados: Sessão deve ter **Assentos Vermelhos** (já ocupados por reservas confirmadas - Risco R2).
    * Cenário Relacionado: Afeta a integridade do `CT-RESERVE-037` (Assento já reservado).
* **Passos para Reprodução:** Selecionar assentos disponíveis (Roxos/Azuis). Clicar no botão "Liberar Assentos" (ou "Limpar Seleção").
* **Comportamento Esperado:** O botão deve apenas desmarcar os assentos que estão atualmente selecionados pelo usuário (Roxos/Azuis). Os assentos **Vermelhos (Reservados) devem permanecer inalterados**.
* **Comportamento Atual:** Ao clicar no botão, **TODOS** os assentos do teatro (incluindo os vermelhos já reservados) são revertidos para o estado Disponível (Verde) no Frontend.
* **Impacto:** **Máximo (Crítico)**. Anulação de reservas válidas, perda de receita, potencial superlotação e corrupção de dados (Risco R2).

---

### **3. [BUG-003] Falha de Regra de Negócio: Não é Possível Selecionar a Opção de Meia Entrada**

* **Pré-condições:**
    * Ambiente de Teste: Página de Seleção de Assentos e/ou Checkout.
    * Cenário Relacionado: Afeta a Lógica/Cálculo de subtotal (`CT-RESERVE-040` e `CT-RESERVE-047`).
* **Passos para Reprodução:** Navegar até a página de Seleção de Assentos, selecionar assentos e observar o cálculo de preço antes ou na tela de Checkout.
* **Comportamento Esperado:** O sistema deve oferecer a opção de selecionar o tipo de ingresso (Inteira/Meia Entrada) e calcular o Subtotal e Valor Total aplicando o desconto da meia entrada.
* **Comportamento Atual:** **Não há opção visível ou funcional** para selecionar "Meia Entrada". O cálculo é feito exclusivamente com o preço de Ingresso Inteiro.
* **Impacto:** Alto Impacto na Lógica de Negócio (Risco R3). Cálculo de receita incorreto e falha de conformidade legal.

---

### **4. [BUG-004] Rota de Checkout (/checkout) é Acessível a Usuários Visitantes (Não Logados)**

* **Pré-condições:**
    * Usuário: Visitante (Não Logado).
    * Rota Crítica: `/checkout` (Página de Pagamento).
* **Passos para Reprodução:** Garantir que o navegador está deslogado. Tentar acessar a rota de Checkout diretamente pela URL: `http://localhost:3002/checkout`.
* **Comportamento Esperado:** O Frontend deveria interceptar o acesso e **redirecionar imediatamente o usuário para a página de Login** (`/login`).
* **Comportamento Atual:** A página de Pagamento/Checkout é carregada e exibida, mesmo sem um usuário autenticado.
* **Impacto:** **Máximo (Crítico)**. Rota de transação desprotegida. Falha na arquitetura de segurança (Risco R1).

---

### **5. [BUG-005] Bloqueio Total de Funcionalidade: Acesso à Página de Administração (/admin) Retorna 404 Not Found**

* **Pré-condições:**
    * Ambiente de Teste: Frontend (Web React).
    * Rota Alvo: `/admin` (Painel de Administração).
* **Passos para Reprodução:** Tentar acessar a rota de Administração diretamente pela URL: `http://localhost:3002/admin`.
* **Comportamento Esperado:** A página de Dashboard Admin deveria carregar se o usuário for um Admin logado, ou redirecionar/exibir erro 403.
* **Comportamento Atual:** O navegador exibe uma página de erro **"404 Not Found"**, indicando que a rota `/admin` não está configurada no roteador do Frontend.
* **Impacto:** **Máximo (Crítico)**. Bloqueio total de funcionalidades de gerenciamento (CRUD de Filmes, Sessões e Teatros), paralisando a operação (P1).

---

### **6. [BUG-006] Falha de Persistência de Sessão: Usuário Recém-Registrado é Deslogado ao Navegar para 'Minhas Reservas' ou 'Perfil'**

* **Pré-condições:**
    * Usuário: Usuário Visitante (em processo de Registro).
* **Passos para Reprodução:** Realizar o Cadastro com sucesso. Após o sucesso do registro, clicar nos links de usuário logado ("Minhas Reservas" ou "Perfil") no cabeçalho.
* **Comportamento Esperado:** O estado de autenticação deve ser mantido, permitindo a navegação para a página solicitada.
* **Comportamento Atual:** Ao clicar no link, o usuário é levado momentaneamente, mas é **imediatamente deslogado/redirecionado para a página de Login**.
* **Impacto:** Alto Impacto na UX. Frustração do usuário recém-registrado e quebra do fluxo de *onboarding* (P3).
