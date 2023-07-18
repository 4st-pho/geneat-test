import 'package:http/http.dart' as http;

String httpErrorHanlder(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;
  return 'Request failed\nStatus Code: $statusCode\nReason: $reasonPhrase';
}
