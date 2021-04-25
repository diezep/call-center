import 'package:call_center/src/core/abstraction/MList.dart';
import 'package:call_center/src/core/structures/MListNode.dart';

class MSimpleList<E> extends MList<E> {
  MSimpleList() : super();

  @override
  E operator [](int index) {
    MListNode<E> aux = anchor;
    if (index < 0) throw MListException.NegativeIndex();

    for (var i = 0; i < index; i++) {
      if (aux.next == null) throw MListException.RangeError();
      aux = aux.next;
    }

    return aux.data;
  }

  @override
  void operator []=(int index, E element) {
    MSimpleList<E> _list = MSimpleList();

    if (index < 0) throw MListException.NegativeIndex();
    if (index > lastIndex) throw MListException.RangeError();

    MListNode tmp = this.anchor;

    for (var i = 0; i < lastIndex; i++) {
      if (i == index) {
        _list.add(element);
        continue;
      }
      _list.add(tmp.data);
      tmp = tmp.next;
    }

    this.anchor = _list.anchor;
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
  void addAll(list) {
    for (var i = 0; i < list.length; i++) this.add(list[i]);
  }

  @override
  MList<E> forEach(Function(E) f) {
    // MListNode tmpNode = anchor;
    // for (var i = 0; i <= lastIndex; i++) {
    //   if (i == index)
    //     tmpData = tmp.data;
    //   else
    //     _list.add(tmp.data);
    //   tmp = tmp.next;
    // }
  }

  @override
  void remove(E element) {
    MSimpleList<E> _list = MSimpleList();
    bool removed = false;

    MListNode<E> tmp = anchor;

    for (var i = 0; i <= lastIndex; i++) {
      if (!removed && tmp?.data == element)
        removed = true;
      else
        _list.add(tmp.data);
      tmp = tmp.next;
    }

    this.lastIndex--;
    this.anchor = _list.anchor;
  }

  @override
  E removeAt(int index) {
    MSimpleList<E> _list = MSimpleList();

    if (index < 0) throw MListException.RangeError();
    if (index > lastIndex) throw MListException.RangeError();

    MListNode tmp = anchor;
    E tmpData;

    for (var i = 0; i <= lastIndex; i++) {
      if (i == index)
        tmpData = tmp.data;
      else
        _list.add(tmp.data);
      tmp = tmp.next;
    }
    this.lastIndex--;
    this.anchor = _list.anchor;
    return tmpData;
  }

  @override
  MList<E> sort([int Function(E, E) compare]) {
    // TODO: implement sort
    throw UnimplementedError();
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
      toString += aux.next == null ? "]" : ", ";
      aux = aux.next;
    }

    return toString;
  }
}
