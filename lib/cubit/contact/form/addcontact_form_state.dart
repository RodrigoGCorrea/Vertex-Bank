part of 'addcontact_form_cubit.dart';

enum AddContactFormStage { intial, sent }

class AddContactFormState extends Equatable {
  const AddContactFormState({
    @required this.nickNameContact,
    @required this.emailContact,
    @required this.stage,
  });

  final String nickNameContact;
  final Email emailContact;
  final AddContactFormStage stage;

  static final empty = AddContactFormState(
    nickNameContact: "",
    emailContact: Email(""),
    stage: AddContactFormStage.intial,
  );

  AddContactFormState copyWith({
    String nickNameContact,
    Email emailContact,
    AddContactFormStage stage,
  }) {
    return AddContactFormState(
      nickNameContact: nickNameContact ?? this.nickNameContact,
      emailContact: emailContact ?? this.emailContact,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object> get props => [
        nickNameContact,
        emailContact,
        stage,
      ];
}
