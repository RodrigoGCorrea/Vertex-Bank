part of 'e_check_action_cubit.dart';

abstract class ECheckActionState extends Equatable {
  const ECheckActionState();

  @override
  List<Object> get props => [];
}

class ECheckActionInitial extends ECheckActionState {}

class ECheckActionLoading extends ECheckActionState {}

class ECheckActionFinished extends ECheckActionState {
  ECheckActionFinished({
    @required this.eCheck,
  });

  final ECheck eCheck;

  @override
  List<Object> get props => [
        eCheck,
      ];
}

class ECheckActionError extends ECheckActionState {
  ECheckActionError({
    @required this.error,
  });

  final Failure error;

  @override
  List<Object> get props => [
        error,
      ];
}
