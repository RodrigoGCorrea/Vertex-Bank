part of 'contact_list_watcher_cubit.dart';

abstract class ContactListWatcherState extends Equatable {
  const ContactListWatcherState();

  @override
  List<Object> get props => [];
}

class ContactListWatcherInitial extends ContactListWatcherState {}

class ContactListWatcherLoading extends ContactListWatcherState {}

class ContactListWatcherFinished extends ContactListWatcherState {
  const ContactListWatcherFinished({
    @required this.contactList,
  }) : super();

  final List<Contact> contactList;

  @override
  List<Object> get props => [contactList];
}

class ContactListWatcherError extends ContactListWatcherState {
  const ContactListWatcherError({
    @required this.error,
  }) : super();

  final Failure error;

  @override
  List<Object> get props => [error];
}
