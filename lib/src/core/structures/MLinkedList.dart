import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/structures/MLinkedListNode.dart';
import 'package:call_center/src/core/structures/MListNode.dart';
import 'package:flutter/material.dart';

class MLinkedList<E> extends MList<E> {
  MLinkedListNode<E> anchor = MLinkedListNode<E>(null);

  @override
  E operator [](int index) {
    MLinkedListNode<E> aux = anchor;
    if (index < 0) throw MListException.NegativeIndex();

    for (var i = 0; i < index; i++) {
      if (aux.next == null) throw MListException.RangeError();
      aux = aux.next;
    }

    return aux.data;
  }

  @override
  void operator []=(int index, E element) {
    MLinkedList<E> _rlist = MLinkedList();

    if (index < 0) throw MListException.NegativeIndex();
    if (index > lastIndex) throw MListException.RangeError();

    MLinkedListNode<E> tmp = this.anchor;

    for (var i = 0; i <= lastIndex; i++) {
      if (index == lastIndex - i) {
        _rlist.add(element);
        tmp = tmp.next;
        continue;
      }
      _rlist.add(tmp.data);
      tmp = tmp.next;
    }
    this.clear();
    this.addAll(_rlist);
  }

  @override
  void add(element) {
    if (anchor == null)
      anchor = MLinkedListNode<E>(element);
    else {
      anchor = MLinkedListNode<E>(element, next: anchor);
    }
    if (anchor.next != null) anchor.next.prev = anchor;

    lastIndex++;
  }

  @override
  void addAll(MList<E> list) {
    list.forEach((element) {
      this.add(element);
    });
  }

  @override
  void remove(E element) {
    MLinkedList<E> _rlist = MLinkedList();
    bool removed = false;

    MLinkedListNode<E> tmp = anchor;

    for (var i = 0; i <= lastIndex; i++) {
      if (!removed && tmp?.data == element)
        removed = true;
      else
        _rlist.add(tmp.data);
      tmp = tmp.next;
    }

    this.clear();
    this.addAll(_rlist);
  }

  @override
  E removeAt(int index) {
    MLinkedList<E> _rlist = MLinkedList();

    if (index < 0) throw MListException.RangeError();
    if (index > lastIndex) throw MListException.RangeError();

    MLinkedListNode<E> tmp = anchor;
    E tmpData;

    for (var i = 0; i <= lastIndex; i++) {
      if (lastIndex - i == index)
        tmpData = tmp.data;
      else
        _rlist.add(tmp.data);
      tmp = tmp.next;
    }
    this.clear();
    this.addAll(_rlist);
    return tmpData;
  }

  @override
  MLinkedList<E> where(bool Function(E) whereFunction) {
    MLinkedList<E> _list = MLinkedList();
    MLinkedListNode<E> tmpAnchor = this.anchor;

    while (tmpAnchor?.data != null) {
      if (whereFunction(tmpAnchor.data)) _list.add(tmpAnchor.data);
      tmpAnchor = tmpAnchor.next;
    }

    return _list;
  }

  @override
  void clear() {
    anchor = null;
    lastIndex = -1;
  }

  @override
  get first => anchor.data;

  @override
  get last => this[lastIndex];

  @override
  bool get isEmpty => anchor.data == null;

  @override
  bool get isNotEmpty => anchor.data != null;

  @override
  int get length => lastIndex + 1;

  @override
  String toString() {
    String toString = "[";
    MLinkedListNode<E> aux = anchor;
    while (aux?.data != null) {
      toString += aux.data.toString();
      toString += aux.next?.data == null ? "]" : ", ";
      aux = aux.next;
    }

    return toString;
  }

  @override
  List map(T Function<T>(E) func) {
    var mappedItems = [];
    MLinkedListNode<E> tmp = anchor;
    E tmpData;

    for (var i = 0; i <= lastIndex; i++) {
      mappedItems.add(func(tmp.data));
      tmp = tmp.next;
    }
    return mappedItems;
  }

  List<Widget> toWidgets(Widget Function(E) func) {
    List<Widget> widgets = [];

    MLinkedListNode<E> tmp = anchor;
    E tmpData;

    for (var i = 0; i <= lastIndex; i++) {
      widgets.add(func(tmp.data));
      tmp = tmp.next;
    }
    return widgets;
  }

  @override
  void forEach(void action(E entry)) {
    if (isEmpty) return;

    MLinkedListNode<E> aux = this.anchor;
    while (aux?.data != null) {
      action(aux.data);
      aux = aux.next;
    }
  }
}
