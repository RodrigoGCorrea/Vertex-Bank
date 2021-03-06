import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:vertexbank/api/contact.dart';
import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';
import 'package:vertexbank/cubit/contact/action/addcontact_action_cubit.dart';
import 'package:vertexbank/cubit/contact/form/addcontact_form_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/login/textbox.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class AddContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddContactFormCubit>(
            create: (context) => AddContactFormCubit()),
        BlocProvider<AddContactActionCubit>(
            create: (context) =>
                AddContactActionCubit(contactApi: getIt<ContactApi>())),
      ],
      child: Scaffold(
        body: BlocListener<AddContactActionCubit, AddContactActionState>(
          listener: (context, state) {
            if (state is AddContactActionError) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.error.message);
            } else if (state is AddContactActionFinished) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess(state.message);
            } else if (state is AddContactActionLoading) {
              EasyLoading.show(status: "Adding contact...");
            }
          },
          child: Background(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: SingleChildScrollView(
                child: Container(
                  height: VtxSizeConfig.screenHeight,
                  child: Column(
                    children: [
                      HeaderAddContact(),
                      SizedBox(height: getProportionateScreenHeight(35)),
                      ContactIdInput(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      NicknameInput(),
                      Spacer(),
                      NextButton(),
                      SizedBox(height: VtxSizeConfig.screenHeight * 0.1)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactFormCubit, AddContactFormState>(
        builder: (context, state) {
      final bool isFormValid = state.emailContact.isValid;
      if (isFormValid) {
        return VtxButton(
          text: "Finish",
          color: AppTheme.buttonColorBlue,
          function: () {
            context.read<AddContactFormCubit>().setContactFormToSentIfValid();
            context.read<AddContactActionCubit>().addContact(
                  context
                      .read<AuthActionCubit>()
                      .getSignedInUserWithoutEmit()
                      .id,
                  state.emailContact.value,
                  state.nickNameContact,
                );
          },
        );
      } else {
        return VtxButton(
          text: "Finish",
          color: AppTheme.buttonColorBlue,
          function: () {
            context
                .read<AddContactFormCubit>()
                .setContactFormToSentIfNotValid();
          },
        );
      }
    });
  }
}

class HeaderAddContact extends StatelessWidget {
  const HeaderAddContact({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: VtxSizeConfig.screenHeight * 0.1),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(horizontal: 42),
        child: Text(
          "Add new contact",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(24),
            fontWeight: FontWeight.bold,
            color: AppTheme.textColorLight,
          ),
        ),
      ),
    );
  }
}

class NicknameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(
        text: "Nickname (optional)",
        onChangedFunction: (nickName) => context
            .read<AddContactFormCubit>()
            .nickNameContactChanged(nickName),
      ),
    );
  }
}

class ContactIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: BlocBuilder<AddContactFormCubit, AddContactFormState>(
        builder: (context, state) {
          return VtxTextBox(
            text: "Contact E-mail",
            onChangedFunction: (email) =>
                context.read<AddContactFormCubit>().contactEmailChanged(email),
            errorText: !state.emailContact.isValid &&
                    state.stage == AddContactFormStage.sent
                ? state.emailContact.errorText
                : null,
          );
        },
      ),
    );
  }
}
