import 'package:call_center/src/core/structures/MListNode.dart';

class MLinkedListNode<E> {
  MLinkedListNode<E> _prev;
  MLinkedListNode<E> _next;
  E _data;

  MLinkedListNode(E data, {MLinkedListNode<E> prev, MLinkedListNode<E> next}) {
    this._data = data ?? null;
    this._prev = prev ?? null;
    this._next = next ?? null;
  }

  set data(E newData) {
    if (!(newData is E)) throw MListNodeException("Data type invalid.");

    this._data = newData;
  }

  set next(MLinkedListNode<E> newNext) {
    if (!(newNext is MLinkedListNode<E>))
      throw MListNodeException("Data type invalid.");

    this._next = newNext;
  }

  set prev(MLinkedListNode<E> newPrev) {
    if (!(newPrev is MLinkedListNode<E>))
      throw MListNodeException("Data type invalid.");

    this._prev = newPrev;
  }

  E get data => this._data;
  MLinkedListNode<E> get next => this._next;
  MLinkedListNode<E> get prev => this._prev;
}
