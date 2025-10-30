*** Settings ***
Resource    ../resources/PageObjects/MoviesListPage.resource
Resource    ../resources/PageObjects/MoviePage.resource
Resource    ../resources/PageObjects/SeatsPage.resource
Library     Browser

Suite Setup       New Browser    chromium    headless=false
Suite Teardown    Close Browser
Test Setup        New Page    http://localhost:3002

*** Test Cases ***
Selecionar E Validar Assento
    [Documentation]    Testa seleção de assento e validação visual
    [Tags]    seats    selecao
    
    Navegar Para Lista De Filmes
    Clicar Ver Detalhes Do Filme
    Clicar Em Selecionar Assentos Da Primeira Sessao
    Selecionar Primeiro Assento Disponivel
    Validar Assento Selecionado
    Validar Lista De Assentos Selecionados
    Validar Valor Total Atualizado

Tentar Selecionar Assento Ocupado
    [Documentation]    Testa que não é possível selecionar assento ocupado (vermelho)
    [Tags]    seats    negativo
    
    Navegar Para Lista De Filmes
    Clicar Ver Detalhes Do Filme
    Clicar Em Selecionar Assentos Da Primeira Sessao
    Tentar Selecionar Assento Ocupado
    Validar Assento Nao Selecionado

Liberar Assentos Selecionados
    [Documentation]    Documenta bug: botão libera assentos vermelhos incorretamente
    [Tags]    seats    bug
    
    Navegar Para Lista De Filmes
    Clicar Ver Detalhes Do Filme
    Clicar Em Selecionar Assentos Da Primeira Sessao
    ${occupied_count_before}=    Get Element Count    ${SEAT_OCCUPIED}
    Selecionar Primeiro Assento Disponivel
    Validar Assento Selecionado
    Clicar Botao Liberar Assentos
    Validar Bug Liberacao Assentos    ${occupied_count_before}

Tentar Continuar Sem Selecionar Assentos
    [Documentation]    Testa se é possível clicar em continuar sem selecionar nenhum assento
    [Tags]    seats    negativo
    
    Navegar Para Lista De Filmes
    Clicar Ver Detalhes Do Filme
    Clicar Em Selecionar Assentos Da Primeira Sessao
    Tentar Clicar Botao Continuar Sem Assentos
    Validar Permanencia Na Pagina De Assentos

Continuar para a compra do ticket
    [Documentation]    Teste se é possível para para a próxima página de compra do ticket após selecionar pelo menos um ${BTN_APLICAR_FILTRO}

    Navegar Para Lista De Filmes
    Clicar Ver Detalhes Do Filme
    Clicar Em Selecionar Assentos Da Primeira Sessao
    Selecionar Primeiro Assento Disponivel
    Validar Assento Selecionado
    Clicar Botao Continuar
    Validar redirecionamento para a próxima página    ${FRONTEND_BASE_URL}/login