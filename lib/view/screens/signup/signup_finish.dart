import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/models/user.dart';
import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/login/textbox.dart';
import 'package:vertexbank/view/components/signUp/cancel_button.dart';
import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';
import 'package:vertexbank/cubit/signup/signup_form_cubit.dart';

class SignUpFinishScreen extends StatelessWidget {
  final _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        body: BlocListener<AuthActionCubit, AuthActionState>(
          listener: (context, state) {
            if (state is AuthActionLoading) {
              EasyLoading.show(status: "Finishing up...");
            } else if (state is AuthActionAuthenticated) {
              EasyLoading.dismiss();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/main', ModalRoute.withName('/'));
            } else if (state is AuthActionError) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.error.message);
            }
          },
          child: _buildSignUpFinishForm(
            context,
            _dobController,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpFinishForm(
    BuildContext context,
    TextEditingController _dobController,
  ) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(
                  VtxSizeConfig.screenHeight * 0.1),
            ),
            _HeaderSignUp(),
            SizedBox(height: getProportionateScreenHeight(35)),
            _buildNameInput(context),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildLastNameInput(context),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildBirthInput(context),
            SizedBox(height: getProportionateScreenHeight(50)),
            _buildFinishButton(context),
            SizedBox(height: getProportionateScreenHeight(13)),
            Text("or", style: TextStyle(color: AppTheme.textColorLight)),
            SizedBox(height: getProportionateScreenHeight(25)),
            CancelButton(),
            SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInput(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) =>
          previous.name != current.name || previous.stage != current.stage,
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            text: "Name",
            onChangedFunction: (name) =>
                context.read<SignUpFormCubit>().nameChanged(name),
            errorText: !state.name.isValid && state.stage != SignUpStage.next
                ? state.name.errorText
                : null,
          ),
        );
      },
    );
  }

  Widget _buildLastNameInput(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) =>
          previous.lastName != current.lastName ||
          previous.stage != current.stage,
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            text: "Last name",
            onChangedFunction: (lastName) =>
                context.read<SignUpFormCubit>().lastNameChanged(lastName),
            errorText:
                !state.lastName.isValid && state.stage != SignUpStage.next
                    ? state.lastName.errorText
                    : null,
          ),
        );
      },
    );
  }

  Widget _buildBirthInput(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: Container(
            height: getProportionateScreenHeight(44),
            decoration: AppTheme.vtxBuildBoxDecoration(),
            child: Center(
              child: _BasicDateField(
                onChanged: (birth) =>
                    context.read<SignUpFormCubit>().birthChanged(
                          birth,
                        ),
                errorText:
                    !state.birth.isValid && state.stage != SignUpStage.next
                        ? state.birth.errorText
                        : null,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return BlocConsumer<SignUpFormCubit, SignUpFormState>(
      listenWhen: (previous, current) => previous.stage != current.stage,
      listener: (context, state) {
        if (state.stage == SignUpStage.finishOk) {
          context.read<AuthActionCubit>().signUp(
                state.finishedUser,
                state.confirmPassword.value,
              );
        }
      },
      builder: (context, state) {
        final isFormValid =
            state.name.isValid & state.lastName.isValid & state.birth.isValid;
        if (isFormValid)
          return VtxButton(
            text: "Finish",
            function: () {
              context
                  .read<SignUpFormCubit>()
                  .setSignUpFormFinishAndRefreshIfValid();

              if (state.finishedUser != User.empty) {
                context.read<AuthActionCubit>().signUp(
                      state.finishedUser,
                      state.confirmPassword.value,
                    );
              }
            },
          );
        else
          return VtxButton(
            text: "Finish",
            function: () => context
                .read<SignUpFormCubit>()
                .setSignUpFormFinishAndRefreshIfNotValid(),
          );
      },
    );
  }
}

class _BasicDateField extends StatelessWidget {
  final Function(DateTime) onChanged;
  final String errorText;
  static double radius = 15;

  const _BasicDateField({
    Key key,
    @required this.onChanged,
    @required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      resetIcon: null,
      style: TextStyle(
        fontSize: getProportionateScreenWidth(14),
        color: AppTheme.textColorDark,
      ),
      format: DateFormat("dd/MM/yyyy"),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.appBackgroundColor,
        contentPadding: EdgeInsets.only(
          left: getProportionateScreenWidth(18),
          top: getProportionateScreenHeight(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColorLight,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColorLight,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        hintText: "Date of birth",
        hintStyle: TextStyle(
          color: AppTheme.textColorDark,
        ),
        errorText: errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColorLight,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColorLight,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onChanged: onChanged,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1920),
          initialDate: currentValue ?? DateTime(DateTime.now().year - 17),
          //At least 18 years old
          lastDate: DateTime(DateTime.now().year - 17),
        );
      },
    );
  }
}

class _HeaderSignUp extends StatelessWidget {
  const _HeaderSignUp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(42)),
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Text(
          "One more thing,",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: AppTheme.textColorLight,
            fontWeight: AppTheme.generalFontWeight,
          ),
        ),
      ),
    );
  }
}
