part of 'addcontact_action_cubit.dart';

abstract class AddContactActionState extends Equatable {
  const AddContactActionState();

  @override
  List<Object> get props => [];
}

class AddContactActionInitial extends AddContactActionState {}

class AddContactActionLoading extends AddContactActionState {}

class AddContactActionFinished extends AddContactActionState {
  const AddContactActionFinished({
    @required this.message,
  }) : super();

  final String message;

  @override
  List<Object> get props => [message];
}

class AddContactActionError extends AddContactActionState {
  const AddContactActionError({
    @required this.error,
  }) : super();

  final Failure error;

  @override
  List<Object> get props => [error];
}
