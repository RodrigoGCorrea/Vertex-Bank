import 'package:get_it/get_it.dart';
import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/api/e_check.dart';
import 'package:vertexbank/api/money.dart';
import 'package:vertexbank/api/transaction_list.dart';
import 'package:vertexbank/api/transfer.dart';
import 'package:vertexbank/cubit/deposit/action/scanner/scanner_deposit_action_cubit.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerSingleton<AuthApi>(AuthApi());
  getIt.registerLazySingleton<TransferApi>(() => TransferApi());
  getIt.registerLazySingleton<MoneyApi>(() => MoneyApi());
  getIt.registerLazySingleton<TransactionListApi>(() => TransactionListApi());
  getIt.registerLazySingleton<ECheckApi>(() => ECheckApi());

  getIt.registerLazySingleton<ScannerDepositActionCubit>(
      () => ScannerDepositActionCubit(eCheckApi: getIt<ECheckApi>()));
}
