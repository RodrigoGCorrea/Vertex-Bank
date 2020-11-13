import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transfer_action_state.dart';

class TransferActionCubit extends Cubit<TransferActionState> {
  TransferActionCubit() : super(TransferActionInitial());
}
