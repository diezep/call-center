import 'package:call_center/src/core/enum/DataType.dart';
import 'package:call_center/src/core/utils.dart';
import 'package:call_center/src/core/values.dart';

class DataInformation {
  int decimals = kDecimalBitsFormat;
  int _bits = 0, _length = 0;
  DataType _dataType;

  DataInformation(this._bits, this._length, this._dataType);

  /// Bits to readable size
  String get bitsFormated => formatBytes(_bits ?? 0, decimals);

  /// Length of data
  int get length => _length ?? 0;

  /// Type of data
  String get textType => dataTypeToString(_dataType);

  /// Length of bites from the data
  int get bits => _bits ?? 0;
}
