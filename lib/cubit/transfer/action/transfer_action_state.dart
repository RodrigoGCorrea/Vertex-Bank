part of 'transfer_action_cubit.dart';

abstract class TransferActionState extends Equatable {
  const TransferActionState();

  @override
  List<Object> get props => [];
}

class TransferActionInitial extends TransferActionState {}

class TransferActionLoading extends TransferActionState {}

class TransferActionCompleted extends TransferActionState {}

class TransferActionError extends TransferActionState {
  TransferActionError({
    @required this.error,
  });

  final Failure error;

  @override
  List<Object> get props => [
        error,
      ];
}
