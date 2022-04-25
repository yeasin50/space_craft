import '../model/model.dart';
import 'provider.dart';

final userSettingProvider = ChangeNotifierProvider.autoDispose<UserSetting>(
  ((ref) {
    return UserSetting();
  }),
);
