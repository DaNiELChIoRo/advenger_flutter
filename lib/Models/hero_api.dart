import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'package:advengers/Models/Hero.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

class HeroApi {
  static Future<List<Character>> fetchCharacters({int start = 0}) async {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    final private = '68aea112681dce29cfb6618f70dbfe79e1963a83';
    final public = 'fb0598dfc94187690bd795309844f3c8';
    final hash = generateMd5('${ts}${private}${public}');
    final queryParameters = {'apikey': public, 'ts': ts, 'hash': hash};
    final response = await http.get(Uri.https(
        "gateway.marvel.com", '/v1/public/characters', queryParameters));

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    final json = jsonDecode(response.body)['data']['results'] as List;
    return json.map<Character>((hero) => Character.fromJson(hero)).toList();
  }
}
