import 'package:call_center/src/core/models/Call.dart';
import 'package:call_center/src/core/structures/MListNode.dart';

abstract class MList<E> {
  MListNode<E> anchor;

  int lastIndex;

  MList() {
    lastIndex = -1;
  }

  /// Get the first element added in list.
  E get first;

  /// Get the last element added in list.
  E get last;

  /// Get the length of the list.
  int get length;

  /// Return true if list is empty.
  bool get isEmpty;

  /// Return true if list is not empty.
  bool get isNotEmpty;

  /// Method to add an element to List
  void add(E element);

  /// Add elements from other List
  void addAll(MList<E> list);

  /// Remove element at specific index
  E removeAt(int index);

  /// Remove the first element equals to argument
  void remove(E element);

  /// Get List of elements that complains the function
  MList<E> where(bool Function(E) whereFunction);

  /// For each element do
  MList<E> forEach(E Function(E) forEach);
  MList<E> sort([int Function(E, E) compare]);
  void clear();
  String toString();

  E operator [](int index);
  operator []=(int index, E element);

  /// In Dart. Private method can't be overrided. It have to be implemented on
  /// extendend class.
  // bool _isValid(int index);

}

class MListException {
  String message;

  MListException(this.message);

  @override
  String toString() => message;

  static MListException RangeError() =>
      MListException("Invalid index. Out of range.");

  static MListException NegativeIndex() =>
      MListException("Invalid index. Can't be negative.");
}