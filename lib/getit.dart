import 'package:get_it/get_it.dart';
import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/api/transfer.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerSingleton<AuthApi>(AuthApi());
  getIt.registerLazySingleton<TransferApi>(() => TransferApi());
}
