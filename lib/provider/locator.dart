import 'package:lotto_board/provider/conversation_provider.dart';
import 'package:lotto_board/provider/user_provider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => ConversationProvider());
  locator.registerLazySingleton(() => UserProvider());
}