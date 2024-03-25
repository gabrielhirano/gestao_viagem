# Entendendo decisões arquiteturais e a estrutura do projeto

## Requisitos para rodar o projeto

### Setup de ambiente:

- Flutter 3.19.0
- Dart 3.3.0

[Download](https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.0-stable.zip)

### Como rodar na minha máquina?

- Clone
```console
git clone https://github.com/gabrielhirano/gestao_viajem.git
```
- Rode
```console
flutter pub get
```
- Rode
```console
flutter packages pub run build_runner build --delete-conflicting-outputs
```
- Pronto 🎉

## Estrutura do Projeto

O projeto esta organizado em duas pastas principais dentro do diretório `lib/`:

### `/core`
A pasta `core` contém todos os arquivos globais que são compartilhados e reutilizados em todo o projeto. Isso inclui:


 - **`/config`**
 Esta subpasta gerencia todas as configurações globais do aplicativo, como injeção de depêndencia e configuração de ambiente.


 - **`/component`**
 Armazena componentes reutilizáveis que podem ser compartilhados entre diferentes telas e funcionalidades, como botões personalizados, diálogos e cartões.


 - **`/layout`**
 Define os layouts base que são usados em todo o aplicativo, garantindo consistência e reutilização de estruturas comuns.


 - **`/theme`**
 Contém a definição do tema do aplicativo, incluindo esquemas de cores, e elementos visuais que seguem as diretrizes da marca Onfly.


 - **`/widget`**
 Reúne widgets personalizados que são específicos para o aplicativo, mas que não se encaixam na categoria de componentes por serem mais complexos ou contextuais.


 - **`/model`**
 Inclui as classes de modelo que representam a estrutura de dados do aplicativo e a lógica de negócios associada.


 - **`/service`**
 Agrupa os serviços que lidam com operações como chamadas de rede, interações com bancos de dados local e controle para sincronização de requisições pendentes.


 - **`/controller`**
 Contém os controladores globais para notificar as views, gerenciando o fluxo de dados e a lógica de negócios.


 - **`/util`**
 Oferece classes utilitárias que fornecem funcionalidades como um navegador e uma abstracao de estado base para o gerenciador de estado


 - **`/helper`**
 Fornece funções auxiliadoras como enum, extension e validator

### `/feature`
Dentro da pasta `feature`, cada subpasta representa uma entidade do sistema. Por exemplo:

- **`/authentication`**: Contém os arquivos relacionados à tela de login, incluindo a view, o controller e o model específicos para autenticação.
- **`/expense`**: Armazena os componentes da funcionalidade de despesas de viagem, como a lista de despesas, adição e edição de despesas.
- **`/boarding_pass`**:Agrupa os elementos que mostram o status das viagens agendadas, incluindo cartão de embarque e informações de voo.

### `main.dart`



## Decisão Arquitetural

A arquitetura do nosso projeto Flutter foi concebida com a simplicidade em mente, garantindo que cada entidade (feature) seja autônoma e de fácil manutenção. A seguir, detalhamos a estrutura e o fluxo de dados adotados:

### Fluxo de Dados e Comunicação

- **View**: A interface do usuário (UI) é projetada para ser minimalista e funcional, recebendo dados diretamente de um `Controller`.
- **Controller**: Atua como intermediário entre a `View` e o `Repository`, gerenciando o estado e as ações do usuário.
- **Repository**: Responsável pela comunicação com fontes de dados externas, utilizando o pacote `Dio` para realizar requisições HTTP.

### Tratamento de Exceções e Retorno de Dados

O `Repository` está equipado com tratamentos de exceções, assegurando que os erros sejam capturado e processado adequadamente. Foram criado cenarios de tratamento de erros apenas para `CacheException` e `ServerException`, o restante dos erros foram tratados como `Exceptions desconhecidas`. Dependendo do resultado da chamada HTTP, o `Repository`:


- Retorna um **Tipo de dado definido** em caso de sucesso, permitindo que o `Controller` atualize a `View` com novos dados.
- Emite uma **Failure** em caso de erro, contendo uma mensagem de erro que será exibida pela `View`.

```dart
class ExpenseController {
  ExpenseController(this.repository);
  final ExpenseRepository repository;

  final state = BaseState<List<ExpenseModel>>();

  Future<void> getExpenses() async {
    await state.execute(() => repository.getExpenses());
  }
}
```

```dart
class ExpenseRepository {
  final Dio client;
  ExpenseRepository({required this.client});

  Future<List<ExpenseModel>> getExpenses() async {
    try {
      final response = await client.get("/expense");

      final dataList = response.data;

      return (dataList as List)
          .map((data) => ExpenseModel.fromMap(data))
          .toList();
    } on CacheException {
      throw CacheFailure('Falha ao buscar dados salvos');
    } catch (err) {
      if (err is ServerException) throw ServerFailure.fromServerException(err);
      throw Failure('Erro Desconhecido!');
    }
  }
}
```

```dart
  @action
  Future<void> execute(Future<T> Function() value) async {
    _state = AppState.loading;
    await value().then((response) {
      if (response.runtimeType == List && (response as List).isEmpty) {
        _state = AppState.empty;
      } else {
        _state = AppState.success;
        _data = response;
      }
    }).onError<Failure>((error, stack) {
      _state = AppState.error;
      _error = error;
    });
  }
}
```
