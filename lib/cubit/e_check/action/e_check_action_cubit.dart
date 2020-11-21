import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vertexbank/api/e_check.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/e_check.dart';

part 'e_check_action_state.dart';

class ECheckActionCubit extends Cubit<ECheckActionState> {
  ECheckActionCubit({
    @required this.eCheckApi,
  }) : super(ECheckActionInitial());

  final ECheckApi eCheckApi;

  Future<void> confirmECheck(String senderId, int amount) async {
    emit(ECheckActionLoading());
    try {
      final generatedECheck = await eCheckApi.makeECheck(senderId, amount);
      emit(ECheckActionFinished(eCheck: generatedECheck));
    } on Failure catch (e) {
      emit(ECheckActionError(error: e));
    }
  }
}
