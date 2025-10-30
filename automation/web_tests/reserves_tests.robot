*** Settings ***
Resource    ../resources/PageObjects/MyReservesPage.resource
Resource    ../resources/PageObjects/LoginPage.resource
Resource    ../resources/PageObjects/SignupPage.resource
Library     Browser

Suite Setup       New Browser    firefox    headless=false
Suite Teardown    Close Browser
Test Setup        New Page    http://localhost:3002

*** Test Cases ***
Verifica se as reservas estão listadas
    [Documentation]    Vai até Minhas Reservas e verifica se existem e se estão no formato correto
    Navegar Para Login
    Realizar Login    ${EMAIL_USER}    ${SENHA_USER}
    Validar Login Bem Sucedido
    Navegar Para Minhas Reservas
    Validar Presenca Reserva No Historico
    Validar Detalhes Essenciais Do Primeiro Card

Tentar acessar apos ser Registrado
    [Documentation]    Registrar um usuario e ir para Minhas Reservas
    ${email_aleatorio}=    Gerar Email Aleatorio
    Navegar Para Cadastro
    Realizar Registro    ${NOME_USER}    ${email_aleatorio}    ${SENHA_USER}
    Validar Registro Bem Sucedido
    Navegar Para Minhas Reservas
    Validar Presenca Reserva No Historico