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

A arquitetura do nosso projeto baseada em `Model-View-Controller (MVC)`. Foi concebida com a simplicidade em mente, garantindo que cada entidade (feature) seja autônoma e de fácil manutenção. A seguir, detalho a estrutura e o fluxo de dados adotados:

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

## Arquitetura Offline First
**Abordagem para armazenamento de dados**: `SharedPreferences`
## Observações Importantes Sobre a Persistência de Dados

> Embora `SharedPreferences` seja utilizado neste projeto para demonstração de conceitos, para implementações em ambientes de produção, recomenda-se o uso de soluções mais robustas. Opções como o `Firebase Realtime Database` são ideais para cenários que exigem capacidade de escuta ativa, permitindo atualizações em tempo real
> 
A implementação é baseada em um `CacheInterceptor` que gerencia as requisições HTTP.

### Cache Interceptor

O `CacheInterceptor` é responsável por interceptar erros de conexão e resolver requisições de duas maneiras:

- **GET Requests**: Quando uma requisição GET é feita, os dados são salvos localmente usando `SharedPreferences`. Se não houver internet, o interceptor busca os dados salvos e retorna na resposta para o repositório.
- **Non-GET Requests**: Para métodos diferentes de GET (POST, PUT, PATCH, DELETE), o interceptor modifica a instância do dado já salvo localmente e adiciona uma pendencia de requisição na fila, essa fila é salva no `SharedPreferences` e posteriormente recuperada e resolvida pelo `WorkManager` mesmo que seu aplicativo não esteja aberto ou em que não esteja em segundo plano;

**Cache Interceptor**
```dart
@override
void onError(DioException err, ErrorInterceptorHandler handler) async {
  if (err.type == DioExceptionType.connectionError) {
    if (err.requestOptions.method == 'GET') {
      await cacheResolver
          .onResolveGet(err.requestOptions)
          .then((response) => handler.resolve(response))
          .onError<DioException>((exception, _) {
        handler.reject(exception);
      });
      return;
    }
    await cacheResolver
        .onResolveChanges(err.requestOptions)
        .then((response) => handler.resolve(response))
        .onError<DioException>((exception, _) => handler.reject(exception));
  }
}

```
**Cache CacheResolver**
```dart
  Future<Response> onResolveGet(RequestOptions requestOptions) async {
    final path = requestOptions.path;

    if (appPreferences.preferences.containsKey(path)) {
      final json = await appPreferences.get(path);

      if (json != null) {
      // Se existir dado localmente ele retorna uma response que será enviada lá para nosso repository
        return Response(
          requestOptions: requestOptions,
          data: jsonDecode(json),
        );
      }
    }
    // Se não encontrar foi porque a 'requisição' falhou e irá retornar um cache exception, porque tentou buscar no cache
    throw CacheException();
  }


  Future<Response> onResolveChanges(RequestOptions requestOptions) async {
    try {
      final baseEndPoint =
          (requestOptions.baseUrl + requestOptions.path).extractBaseEndPoint;
      // se não encontrar o BaseEndpoint que é a chave de acesso aos dados salvos do methodo GET ele irá retornar uma exception
      if (baseEndPoint == null) throw CacheException;
      
      
      final responseGet = await onResolveGet(
        RequestOptions(path: baseEndPoint),
      );

     // como são solicitações de modificação do conjunto de dados ele irá usar essa instancia para ser manipulada e então
     // sobrescrever o conjunto antigo com esse novo
      final data = responseGet.data as List; 
                                             
      final requestObject = jsonDecode(requestOptions.data);

      switch (requestOptions.method) {
        case 'POST':
          data.add(requestObject);
          break;
        case 'PUT':
        case 'PATCH':
          for (Map<String, dynamic> object in data) {
            if (requestObject['id'] == object['id']) {
              object.clear();
              object.addAll(requestObject);
            }
          }
          break;
        case 'DELETE':
          data.removeWhere((object) => object['id'] == requestObject['id']);
          break;
      }
      final response = Response(
        requestOptions: RequestOptions(path: baseEndPoint),
        data: data,
      );

      // sobrescreve o conjunto antigo
      saveResponseOnCache(response); 

      // salva a requisição localmente, será adicionado em uma fila na qual o metodo é a chave, salvamos o
      // tipo da requisição e os dados que foram enviados para posteriormente recuperar e completar essa pendencia
      saveRequestPendingOnCache(requestOptions);   
                                                 
      return response;
    } on FormatException {
      throw Exception('Erro ao fazer conversão de tipo de dado.');
    } catch (e) {
      throw CacheException();
    }
  }

```
**WorkManagerDispacherService**
```dart 
  // o Workmanager é basicamente um isolate (thread) que opera em background, por não compartilhar o mesmo ciclo de vida do app,
  // mesmo se o app não tiver aberto em memoria ele ainda assim irá executar a task 
  

  // ao salvar executar o saveRequestPendingOnCache e salvar a pendencia local ele irá registrar uma task no Workmanager
  static Future<void> registerPendingRequest() async {
    if (await hasPendingRequest()) return;

    final uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    await Workmanager().registerPeriodicTask(
      uniqueName,
      'hasPendingRequest',
      constraints: Constraints(networkType: NetworkType.connected),
      inputData: {
        'uniqueName': uniqueName,
      },
    );
  }
 
  // esse é a função que sera executada apos uma task ser registrada.
  static Future<bool> dispatcher(
    String taskName,
    Map<String, dynamic>? inputData,
  ) async {
    if (taskName == 'hasPendingRequest') {
      await _resolveRequests();

      return Future.value(true);
    }
    return Future.value(false);
  }
  
// esse metodo ira receber o tipo de requisição e uma Future e apos ela ser completada ele irá remover as pendencias
// de requisição daquele metodo
  static Future _resolveRequestRetry(HttpMethods method, Future procedure) {
    return procedure.then((_) {
      _preferences.delete(method.name);
    });
  }

  static Future<void> _resolveRequests() async {
    await _initialize(); // necessario criar uma nova instancia do preferences;
  
    final posts = await _preferences.getList(HttpMethods.post.name);
    final put = await _preferences.getList(HttpMethods.put.name);
    final patch = await _preferences.getList(HttpMethods.patch.name);
    final delete = await _preferences.getList(HttpMethods.delete.name);
    // aqui ele vai verificar todas as filas de requisições e irá resolver por ordem de prioridade
    // post > put > patch > delete 

    // no metodo post podemos usar um Future.wait e enviar multiplas requisições ao mesmo tempo;
    if (posts.isNotEmpty) {
      final postsRequests = posts.map(CustomRequestOptions.fromJson).toList();
      await _resolveRequestRetry(
        HttpMethods.post,
        Future.wait(postsRequests.map(_requestRetrier.requestRetry).toList()),
      );
    }

    // no caso de put e patch tem que ser sequencial para não ocorrer conflitos
    if (put.isNotEmpty) {
      final putRequests = put.map(CustomRequestOptions.fromJson).toList();

      List<Future<dynamic> Function()> functionList = putRequests
          .map((request) =>
              () async => (await _requestRetrier.requestRetry(request)).data)
          .toList();

      await _resolveRequestRetry(
        HttpMethods.put,
        runQueue(functionList),
      );
    }

    if (patch.isNotEmpty) {
      final patchRequests = patch.map(CustomRequestOptions.fromJson).toList();
      List<Future<dynamic> Function()> functionList = patchRequests
          .map((request) =>
              () async => (await _requestRetrier.requestRetry(request)).data)
          .toList();

      await _resolveRequestRetry(
        HttpMethods.patch,
        runQueue(functionList),
      );
    }
    // delete é o mesmo caso do post
    if (delete.isNotEmpty) {
      final deleteRequests = delete.map(CustomRequestOptions.fromJson).toList();
      await _resolveRequestRetry(
        HttpMethods.delete,
        Future.wait(deleteRequests.map(_requestRetrier.requestRetry).toList()),
      );
    }
  }



```
