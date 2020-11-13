import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/api/transfer.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/transaction.dart';

part 'transfer_action_state.dart';

class TransferActionCubit extends Cubit<TransferActionState> {
  TransferActionCubit({@required this.transferApi})
      : super(TransferActionInitial());

  final TransferApi transferApi;

  void completeTransfer(Transaction sender, Transaction receiver) async {
    try {
      emit(TransferActionLoading());
      await transferApi.makeTransfer(
        receiver.id,
        sender.id,
        sender,
        receiver,
      );
      emit(TransferActionCompleted());
    } on Failure catch (e) {
      emit(TransferActionError(error: e));
    }
  }
}
