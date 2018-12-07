import 'dart:math';

import 'node.dart';

const infinity = 1000000000;

num minimax(Node<num> node, int players, int playerIndex) {
  print("visited ${node}");

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

num alphaBeta(
    Node<num> node, int players, int playerIndex, num alpha, num beta) {
  print("visited ${node}");

  if (node.terminal) return node.value;

  int nextPlayer = (playerIndex + 1) % (players + 1);

  if (playerIndex != 1) {
    var value = infinity;

    for (var x in node.children) {
      value = min(value, alphaBeta(x, players, nextPlayer, alpha, beta));
      beta = min(beta, value);

      if (alpha >= beta) break;
    }

    return node.value = value;
  } else {
    var value = -infinity;

    for (var x in node.children) {
      value = max(value, alphaBeta(x, players, nextPlayer, alpha, beta));
      alpha = max(alpha, value);

      if (alpha >= beta) break;
    }

    return node.value = value;
  }
}
