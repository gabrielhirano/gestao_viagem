enum HttpMethods {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  const HttpMethods(this.name);
  final String name;

  static HttpMethods fromString(String category) {
    return {
          'GET': HttpMethods.get,
          'POST': HttpMethods.post,
          'PUT': HttpMethods.put,
          'PATCH': HttpMethods.patch,
          'DELETE': HttpMethods.delete,
        }[category] ??
        HttpMethods.get;
  }
}
