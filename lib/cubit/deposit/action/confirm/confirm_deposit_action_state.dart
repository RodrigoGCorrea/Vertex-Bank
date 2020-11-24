part of 'confirm_deposit_action_cubit.dart';

abstract class ConfirmDepositActionState extends Equatable {
  const ConfirmDepositActionState();

  @override
  List<Object> get props => [];
}

class ConfirmDepositActionInitial extends ConfirmDepositActionState {}

class ConfirmDepositActionLoading extends ConfirmDepositActionState {}

class ConfirmDepositActionError extends ConfirmDepositActionState {
  const ConfirmDepositActionError({
    @required this.error,
  });

  final Failure error;

  @override
  List<Object> get props => [
        error,
      ];
}

class ConfirmDepositActionFinished extends ConfirmDepositActionState {}
