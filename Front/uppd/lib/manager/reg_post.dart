
import 'dart:convert';
import 'package:http/http.dart' as http;

singup(String name,pas) async {
final http.Response response = await http.post(
  Uri.parse('http://localhost:3000/api/user/createAc'),
  headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    },
  body: jsonEncode(<String, String>{
    'pas': pas,
    'name':name,
    }),
  );
print(response.body);
    // print(response.body);

}