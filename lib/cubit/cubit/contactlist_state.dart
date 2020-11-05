part of 'contactlist_cubit.dart';

abstract class ContactlistState extends Equatable {
  const ContactlistState();

  @override
  List<Object> get props => [];
}

class ContactlistInitial extends ContactlistState {
  final List<ContactListItem> contactList;
  final int indexContactListSelected;

  ContactlistInitial({
    this.contactList,
    this.indexContactListSelected,
  }) : super();

  @override
  List<Object> get props => [contactList, indexContactListSelected];
}
