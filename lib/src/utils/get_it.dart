import 'package:get_it/get_it.dart';

import '../provider/user.dart';

GetIt getIt = GetIt.instance;

void getItProvider() {
  getIt.registerFactory(() => UsersProvider());
  // getIt.registerFactory(() => CategoriesProvider());
}
