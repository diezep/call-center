import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/structures/MListNode.dart';
import 'package:flutter/material.dart';

class MSimpleList<E> extends MList<E> {
  MSimpleList() : super();

  MListNode<E> anchor;

  @override
  E operator [](int index) {
    MListNode<E> aux = anchor;
    if (index < 0) throw MListException.NegativeIndex();

    for (int i = 0; i < lastIndex - index; i++) {
      if (aux.next == null) throw MListException.RangeError();
      aux = aux.next;
    }
    return aux.data;
  }

  @override
  void operator []=(int index, E element) {
    MSimpleList<E> _rlist = MSimpleList();

    if (index < 0) throw MListException.NegativeIndex();
    if (index > lastIndex) throw MListException.RangeError();

    MListNode tmp = this.anchor;

    for (int i = 0; i <= lastIndex; i++) {
      if (lastIndex - i == index) {
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
      anchor = MListNode<E>(element);
    else {
      anchor = MListNode<E>(element, anchor);
    }

    lastIndex++;
  }

  @override
  void addAll(MList<E> list) {
    list?.forEach((element) {
      this.add(element);
    });
  }

  @override
  void remove(E element) {
    MSimpleList<E> _rlist = MSimpleList();
    bool removed = false;

    MListNode<E> tmp = anchor;

    for (int i = 0; i <= lastIndex; i++) {
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
    MSimpleList<E> _rlist = MSimpleList();

    if (index < 0) throw MListException.RangeError();
    if (index > lastIndex) throw MListException.RangeError();

    MListNode tmp = anchor;
    E tmpData;

    for (int i = 0; i <= lastIndex; i++) {
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
  MSimpleList<E> where(bool Function(E) whereFunction) {
    MSimpleList<E> _list = MSimpleList();
    MListNode<E> tmpAnchor = this.anchor;

    while (tmpAnchor?.data != null) {
      if (whereFunction(tmpAnchor.data)) _list.add(tmpAnchor.data);
      tmpAnchor = tmpAnchor.next;
    }

    return _list;
  }

  @override
  int indexWhere(bool Function(E) whereFunction) {
    MListNode<E> tmpAnchor = this.anchor;
    int index = 0;
    while (tmpAnchor?.data != null) {
      if (whereFunction(tmpAnchor.data)) return index;
      tmpAnchor = tmpAnchor.next;
      index++;
    }

    return null;
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
  bool get isEmpty => anchor == null;

  @override
  bool get isNotEmpty => anchor != null;

  @override
  int get length => lastIndex + 1;

  @override
  String toString() {
    String toString = "[";
    MListNode<E> aux = anchor;
    while (aux?.data != null) {
      toString += "${aux.data}";
      toString += aux?.next == null ? "]" : ", ";
      aux = aux.next;
    }

    return toString;
  }

  List<Widget> toWidgets(Widget Function(E) func) {
    List<Widget> widgets = [];

    MListNode tmp = anchor;

    for (int i = 0; i <= lastIndex; i++) {
      widgets.add(func(tmp.data));
      tmp = tmp.next;
    }
    return widgets;
  }

  @override
  void forEach(void action(E entry)) {
    if (isEmpty) return;

    MListNode<E> aux = anchor;
    while (aux?.data != null) {
      action(aux.data);
      aux = aux.next;
    }
  }
}
