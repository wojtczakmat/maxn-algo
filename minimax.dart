import 'dart:math';

import 'node.dart';

const infinity = 1000000000;

num minimax(Node<num> node, int players, int playerIndex) {
  if (node.terminal) return node.value;

  int nextPlayer = (playerIndex + 1) % (players + 1);
  var currentBest = 0;

  if (playerIndex != 1) {
    currentBest = infinity;
    node.children.forEach(
        (x) => currentBest = min(currentBest, minimax(x, players, nextPlayer)));
  } else {
    currentBest = -infinity;
    node.children.forEach(
        (x) => currentBest = max(currentBest, minimax(x, players, nextPlayer)));
  }

  return node.value = currentBest;
}

List<num> maxn(Node<List<num>> node, int players, int playerIndex) {
  if (node.terminal) return node.value;

  int nextPlayer = (playerIndex + 1) % (players + 1);
  var best = maxn(node.children[0], players, nextPlayer);

  for (var child in node.children.skip(1)) {
    var curr = maxn(child, players, nextPlayer);
    if (curr[playerIndex - 1] > best[playerIndex - 1]) best = curr;
  }

  return node.value = best;
}
