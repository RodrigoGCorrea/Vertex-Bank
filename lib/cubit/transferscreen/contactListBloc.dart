import 'dart:async';

import 'package:vertexbank/components/transferscreen/contactlist.dart';

class ContactListBloc {
  int _indexContactListSelected;
  List<ContactListItem> contactList;

  final StreamController<List<ContactListItem>> _streamController =
      StreamController<List<ContactListItem>>();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void selectContact(int index) {
    if (_indexContactListSelected != null) {
      contactList[_indexContactListSelected].isSelected = false;
      print("alou");
    }
    contactList[index].isSelected = !contactList[index].isSelected;
    _indexContactListSelected = index;
    input.add(contactList);
  }

  void setContactList(List<ContactListItem> list) {
    contactList = list;
    input.add(contactList);
  }
}
