class Node<T> {
  Node(this.value, {this.children});

  factory Node.fromMap(Map map) {
    if (map == null) return null;

    if (map["value"] is List) {
      map["value"] = (map["value"] as List).cast<int>();
    }

    return Node(map["value"],
        children:
            (map["children"] as List).map((x) => Node<T>.fromMap(x)).toList());
  }

  List<Node<T>> children;
  T value;

  bool get terminal => children.isEmpty;

  @override
  String toString() => terminal
      ? '{v: $value}'
      : '{v: $value, c: {${children.map((x) => x.toString()).join(" ")}}';

  Map toMap() =>
      {"value": value, "children": children.map((x) => x.toMap()).toList()};
}
