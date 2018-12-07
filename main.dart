import 'dart:io';
import 'dart:convert';

import 'minimax.dart';
import 'node.dart';

Future<Node<T>> readFromJson<T>(String filename) async {
  return File(filename)
      .readAsString()
      .then((fileContents) => jsonDecode(fileContents) as Map)
      .then((jsonData) {
    return Node<T>.fromMap(jsonData);
  });
}

Future writeToJson<T>(Node<T> root, String filename) {
  return File(filename).writeAsString(jsonEncode(root.toMap()));
}

void main(List<String> args) async {
  int players = args.length >= 2 ? int.parse(args[1]) : 2;

  if (args.last == "--maxn") {
    Node<List<int>> root = await readFromJson(args[0]);
    print(maxn(root, players, 1));
    await writeToJson(root, 'result.json');
  } else {
    Node<int> root = await readFromJson(args[0]);
    print(minimax(root, players, 1));
    await writeToJson(root, 'result.json');
  }
}
