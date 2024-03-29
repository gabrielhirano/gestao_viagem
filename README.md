# Progresso e Testes Implementados

## Documentação

A documentação detalhada sobre as escolhas de design e arquitetura, explicando as decisões tomadas e as metodologias aplicadas durante o desenvolvimento.

> [**Justificativa de Design e Arquitetura**](https://github.com/gabrielhirano/gestao_viajem/blob/master/STRUCTURE.md)


## Funcionalidades Completas

- **Funcionalidade Offline First**: Implementação bem-sucedida utilizando uma API mock para testar a sincronização, visualização, alteração e adição de despesas. A funcionalidade garante que os dados sejam armazenados localmente e sincronizados com o servidor quando houver conexão disponível.

- **Viagens Agendadas**: Desenvolvimento da visualização de viagens agendadas utilizando dados mockados. Esta funcionalidade permite aos usuários visualizar informações sobre suas viagens programadas, como cartão de embarque, horário de voo, companhia aérea e aeroporto.

## Funcionalidades Pendentes

- **Tela de Login**: A tela de login, que permitirá aos usuários acessar o aplicativo usando e-mail e senha, ainda está em desenvolvimento.

- **Dados do Cartão Corporativo**: A implementação da tela que exibe informações do cartão corporativo do usuário, como saldo, bandeira e extrato, está pendente.

- **Relatórios de Despesas**: A funcionalidade para gerar relatórios detalhados de despesas, com gráficos e filtros para diferentes períodos, ainda não foi implementada.

> **Observações**: A criação das interfaces de usuário (UI) será realizada utilizando dados simulados (mockados), focando exclusivamente no desenvolvimento da UI. Este método foi aplicado anteriormente na funcionalidade de viagem, servindo como prova das minhas competências. A única observação é em relação à implementação de gráficos, para a qual planejo utilizar as bibliotecas `d_chart` ou `flutter_charts`. Ambas oferecem uma abordagem simplificada para a ingestão de dados e sua subsequente representação gráfica.


## Testes


### Como rodar os testes?

- Apos configurar setup, como explicado na documentação abaixo.
> [**Justificativa de Design e Arquitetura**](https://github.com/gabrielhirano/gestao_viajem/blob/master/STRUCTURE.md)

### **Se optou por usar o derry**
- Rode
```console
derry view_test
```

### **Tradicional**
- Rode
```console
flutter test
```


**Testes Unitários**:
### `/core`
- **`/util`**
Implementado teste para o `BaseState`, que é a abstração utilizada para o gerenciamento de estado da aplicação.

### `/feature`
- **`/expense`**
Desenvolvidos testes para as camadas de `model`, `controller` e `repository`.
- **`/home`**
Desenvolvido teste para camada de `view` verificando apenas as trocas de estados possiveis da home

Este documento serve como um registro do progresso atual do projeto e das funcionalidades que foram testadas e validadas até o momento.
