*** Settings ***
Resource    ../resources/PageObjects/HomePage.resource
Resource    ../resources/PageObjects/MoviesListPage.resource
Library     Browser

Suite Setup       New Browser    firefox    headless=false
Suite Teardown    Close Browser
Test Setup        New Page    http://localhost:3002


*** Test Cases ***
Verifica se os botões do cabecalho estão funcionando
    Navegar Para Cadastro
    Navegar Para Login
    Navegar Para Lista De Filmes da Página Inicial
    Navegar Para Inicio
    Clicar na logo
    
Verifica se os botões da página estão funcionando
    Clicar Ver Todos Filmes Em Cartaz
    Clicar na logo
    Clicar No Detalhe Do Primeiro Filme
    Validar Redirecionamento Para Detalhes
