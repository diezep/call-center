import 'package:call_center/src/core/structures/MListNode.dart';

class MLinkedListNode<E> extends MListNode<E> {
  MListNode<E> prev;

  MLinkedListNode(E data, [this.prev, MListNode<E> next]) : super(data, next);
}
