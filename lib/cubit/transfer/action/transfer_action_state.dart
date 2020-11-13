part of 'transfer_action_cubit.dart';

abstract class TransferActionState extends Equatable {
  const TransferActionState();

  @override
  List<Object> get props => [];
}

class TransferActionInitial extends TransferActionState {}

class TransferActionLoading extends TransferActionState {}

class TransferActionCompleted extends TransferActionState {}
