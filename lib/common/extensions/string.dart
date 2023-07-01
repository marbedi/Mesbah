import '../utils/utils.dart';

extension FarsiNumber on String {
  String toFarsiNumber() {
    return replaceFarsiNumber(this);
  }
}
