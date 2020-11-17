import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/components/back_button.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/login/textbox.dart';
import 'package:vertexbank/view/components/signUp/cancel_button.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/cubit/signup/signup_form_cubit.dart';

class SignUpFinishScreen extends StatelessWidget {
  final _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              // For some misterious reason flutter does not provide
              // pushAndRemoveUntil with named routes...
              Navigator.popUntil(context, ModalRoute.withName('/login'));
              Navigator.pushReplacementNamed(context, '/main');
            } else if (state is ErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.message),
                ),
              );
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
    return _Background(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildBackButton(),
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
            Text("or", style: TextStyle(color: AppTheme.textColor)),
            SizedBox(height: getProportionateScreenHeight(25)),
            CancelButton(),
            SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
            //NOTE(Geraldo): O que esse BackButton faz?
            BackButton()
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

  //NOTE(Geraldo): Não sei usar o campo de data ali, vou ver isso dps
  Widget _buildBirthInput(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(
        text: "Birthday",
        onChangedFunction: (birth) =>
            context.read<SignUpFormCubit>().birthChanged(birth: birth),
      ),
    );
  }

  //NOTE(Gealdo): Vou usar um input de texto pra data por enquanto, só pra debug.
  /*Widget _buildBirthInput(TextEditingController _dobController) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: _BasicDateField(
        controller: _dobController,
      ),
    );
  }*/

  Widget _buildBackButton() {
    return Stack(
      children: [
        SizedBox(
          height: VtxSizeConfig.screenHeight * 0.11,
          width: VtxSizeConfig.screenWidth,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(22),
          ),
          child: VtxBackButton(),
        ),
      ],
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      builder: (context, state) {
        final isFormValid =
            state.name.isValid & state.lastName.isValid & (state.birth != null);
        if (isFormValid)
          return VtxButton(
              text: "Finish",
              function: () {
                context.read<SignUpFormCubit>().setSignUpFormFinishAndRefresh();
                context.read<AuthCubit>().signUp(
                      state.finishedUser,
                      state.confirmPassword.value,
                    );
              });
        else
          return VtxButton(
            text: "Finish",
            function: () =>
                context.read<SignUpFormCubit>().setSignUpFormFinishAndRefresh(),
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
            color: AppTheme.textColor,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final Widget child;

  const _Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: VtxSizeConfig.screenWidth,
      height: VtxSizeConfig.screenHeight,
      color: AppTheme.appBackgroundColor,
      child: child,
    );
  }
}

class _BasicDateField extends StatelessWidget {
  final TextEditingController controller;

  const _BasicDateField({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      controller: controller,
      resetIcon: null,
      style: TextStyle(
        fontSize: getProportionateScreenWidth(14),
        color: AppTheme.textColor,
      ),
      format: DateFormat("dd/MM/yyyy"),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(18),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: "Date of birth",
        labelStyle: TextStyle(
          color: AppTheme.textColor,
        ),
      ),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
      },
    );
  }
}
