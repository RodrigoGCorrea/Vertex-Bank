import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vertexbank/components/transferscreen/contactlist.dart';

part 'contactlist_state.dart';

class ContactlistCubit extends Cubit<ContactlistState> {
  ContactlistCubit()
      : super(ContactlistInitial(
          contactList: [],
          indexContactListSelected: null,
        ));

  void selectContact(int index) {
    final lstate = state as ContactlistInitial;
    List<ContactListItem> listState = lstate.contactList;
    int lastIndex = lstate.indexContactListSelected;
    listState[index].isSelected = !listState[index].isSelected;
    if (lastIndex != null) {
      listState[lastIndex].isSelected = false;
    }
    if (lastIndex == index)
      lastIndex = null;
    else
      lastIndex = index;
    emit(ContactlistInitial(
      contactList: listState,
      indexContactListSelected: lastIndex,
    ));
  }

  void setContactList(List<ContactListItem> list) {
    emit(ContactlistInitial(
      contactList: list,
      indexContactListSelected: null,
    ));
  }
}
