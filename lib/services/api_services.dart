import 'package:http/http.dart' as http;

Future<http.Response> fetchProducts() async {
  const String apiUrl = "https://fakestoreapi.com/products";
  http.Response response = await http.get(
    Uri.parse(apiUrl),
  );

  return response;
}
