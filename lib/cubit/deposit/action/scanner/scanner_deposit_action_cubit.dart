import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:vertexbank/api/e_check.dart';

import 'package:vertexbank/models/e_check.dart';
import 'package:vertexbank/models/failure.dart';

part 'scanner_deposit_action_state.dart';

class ScannerDepositActionCubit extends Cubit<ScannerDepositActionState> {
  ScannerDepositActionCubit({
    @required this.eCheckApi,
  }) : super(ScannerDepositActionInitial());

  final ECheckApi eCheckApi;

  Future<void> parseECheckFromJson(String jsonECheck) async {
    emit(ScannerDepositActionInitial());
    try {
      emit(ScannerDepositActionLoading());
      final echeck = ECheck.fromJson(jsonECheck);

      if (echeck.amount == null ||
          echeck.checkID == null ||
          echeck.senderID == null) throw FormatException;

      await eCheckApi.isCheckValid(echeck.senderID, echeck.checkID);

      final senderName = await eCheckApi.getCheckOwnerName(echeck.senderID);

      emit(ScannerDepositActionFinished(
          parsedECheck: echeck, senderName: senderName));
    } on FormatException {
      emit(
        ScannerDepositActionError(
          error: Failure("This is not a valid E-Check."),
        ),
      );
    } on Failure catch (e) {
      emit(ScannerDepositActionError(error: e));
    }
  }
}
