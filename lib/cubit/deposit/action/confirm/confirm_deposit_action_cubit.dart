import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:vertexbank/api/e_check.dart';

import 'package:vertexbank/models/e_check.dart';
import 'package:vertexbank/models/failure.dart';

part 'confirm_deposit_action_state.dart';

class ConfirmDepositActionCubit extends Cubit<ConfirmDepositActionState> {
  ConfirmDepositActionCubit({
    @required this.eCheckApi,
  }) : super(ConfirmDepositActionInitial());

  final ECheckApi eCheckApi;

  Future<void> confirmDeposit(ECheck eCheck, String receiverId) async {
    emit(ConfirmDepositActionInitial());
    try {
      emit(ConfirmDepositActionLoading());
      await eCheckApi.depositCheck(eCheck, receiverId);
      emit(ConfirmDepositActionFinished());
    } on Failure catch (e) {
      emit(ConfirmDepositActionError(error: e));
    }
  }
}
