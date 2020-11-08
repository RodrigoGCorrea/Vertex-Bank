import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/models/inputs/email.dart';
import 'package:vertexbank/models/inputs/name.dart';
import 'package:vertexbank/models/inputs/password.dart';
import 'package:vertexbank/models/user.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    @required this.authCubit,
  }) : super(
          SignupInitial.empty,
        );

  final AuthCubit authCubit;

  void finishSignUp() {
    final lstate = state as SignupInitial;

    if (lstate.email.isValid &&
        lstate.password.isValid &&
        lstate.confirmPassword.isValid &&
        lstate.name.isValid &&
        lstate.lastName.isValid &&
        lstate.birth != null) {
      final User user = User(
        email: lstate.email.value,
        name: lstate.name.value,
        lastName: lstate.lastName.value,
        birth: lstate.birth.toString(),
        id: "",
      );

      authCubit.signUp(
        user,
        lstate.confirmPassword.value,
      );
      emit(lstate.copyWith(wasSent: SingupSentFrom.finish));
    } else {
      // This is to refresh the inputs
      emit(lstate.copyWith(wasSent: SingupSentFrom.finish));
      emailChanged(lstate.email.value);
      passwordChanged(lstate.password.value);
      passwordConfirmChanged(lstate.confirmPassword.value);
      nameChanged(lstate.name.value);
      lastNameChanged(lstate.lastName.value);

      //NOTE(Geraldo): lidar com o campo de idade depois
    }
  }

  void nextStage() {
    final lstate = state as SignupInitial;
    if (lstate.email.isValid &&
        lstate.password.isValid &&
        lstate.confirmPassword.isValid) {
      emit(lstate.copyWith(wasSent: SingupSentFrom.nextFinish));
    } else {
      emit(lstate.copyWith(wasSent: SingupSentFrom.next));
    }
    // This is to refresh the inputs
    emailChanged(lstate.email.value);
    passwordChanged(lstate.password.value);
    passwordConfirmChanged(lstate.confirmPassword.value);
  }

  void emailChanged(String email) {
    final lstate = state as SignupInitial;
    final isValid = Email.validate(email);
    final newEmail = Email(email, isValid: isValid);
    emit(
      lstate.copyWith(
        email: newEmail,
      ),
    );
  }

  void passwordChanged(String password) {
    final lstate = state as SignupInitial;
    final isValid = Password.validate(password);
    final newPassword = Password(password, isValid: isValid);
    emit(
      lstate.copyWith(
        password: newPassword,
      ),
    );
  }

  void passwordConfirmChanged(String confPassword) {
    final lstate = state as SignupInitial;
    bool isValid;
    String errorText;
    Password newConfPassword;

    if (lstate.password.value != confPassword) {
      isValid = false;
      errorText = Password.mustMatch;
    } else if (!Password.validate(confPassword)) {
      isValid = false;
      errorText = Password.minChar;
    } else {
      isValid = true;
      errorText = Password.minChar;
    }

    newConfPassword = Password(
      confPassword,
      isValid: isValid,
      errorText: errorText,
    );
    emit(
      lstate.copyWith(
        confirmPassword: newConfPassword,
      ),
    );
  }

  void nameChanged(String name) {
    final lstate = state as SignupInitial;
    final isValid = Name.validate(name);
    final newName = Name(name, isValid: isValid);
    emit(
      lstate.copyWith(
        name: newName,
      ),
    );
  }

  void lastNameChanged(String lastName) {
    final lstate = state as SignupInitial;
    final isValid = Name.validate(lastName);
    final newLastName = Name(lastName, isValid: isValid);
    emit(
      lstate.copyWith(
        lastName: newLastName,
      ),
    );
  }

  void birthChanged(String birth) {
    final lstate = state as SignupInitial;

    //NOTE(Geraldo): Não sei se o parse retorna algum tipo de erro...
    final parsedBirth = DateFormat("dd/MM/yyyy").parse(birth);
    emit(
      lstate.copyWith(
        birth: parsedBirth,
      ),
    );
  }
}
