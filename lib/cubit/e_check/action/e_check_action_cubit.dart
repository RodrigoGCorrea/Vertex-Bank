import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vertexbank/models/failure.dart';
import 'package:vertexbank/models/e_check.dart';

part 'e_check_action_state.dart';

class EcheckactionCubit extends Cubit<ECheckActionState> {
  EcheckactionCubit() : super(ECheckActionInitial());
}
