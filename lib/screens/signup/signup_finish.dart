import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/back_button.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/signUp/cancel_button.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/cubit/signup/signup_cubit.dart';

class SignUpFinishScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dobController = TextEditingController();
    return Scaffold(
      body: _buildSignUpFinishForm(
        context,
        _dobController,
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
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        if (state is SignupInitial) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(52)),
            child: VtxTextBox(
              text: "Name",
              onChangedFunction: (name) =>
                  context.read<SignupCubit>().nameChanged(name),
              errorText: !state.name.isValid &&
                      state.wasSent != SingupSentFrom.nextFinish
                  ? state.name.errorText
                  : null,
            ),
          );
        }
        // NOTE(Geraldo): não sei o que retornar aqui, mas a principio não é pra
        //                chegar nesse caso
        return null;
      },
    );
  }

  Widget _buildLastNameInput(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        if (state is SignupInitial) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(52)),
            child: VtxTextBox(
              text: "Last name",
              onChangedFunction: (lastName) =>
                  context.read<SignupCubit>().lastNameChanged(lastName),
              errorText: !state.lastName.isValid &&
                      state.wasSent != SingupSentFrom.nextFinish
                  ? state.lastName.errorText
                  : null,
            ),
          );
        }
        // NOTE(Geraldo): não sei o que retornar aqui, mas a principio não é pra
        //                chegar nesse caso
        return null;
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
            context.read<SignupCubit>().birthChanged(birth),
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
}

Widget _buildFinishButton(BuildContext context) {
  return BlocListener<AuthCubit, AuthState>(
    listener: (context, state) {
      if (state is AuthenticatedState) {
        Navigator.of(context).pushNamed('/');
      } else if (state is ErrorState) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error.message),
          ),
        );
      }
    },
    child: VtxButton(
      text: "Finish",
      function: () => context.read<SignupCubit>().finishSignUp(),
    ),
  );
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
      child: VtxGradient(
        begin: Alignment.topLeft,
        color: AppTheme.generalColorBlue,
        child: VtxGradient(
          begin: Alignment.topRight,
          end: Alignment(0.06, 0),
          color: AppTheme.generalColorGreen.withOpacity(0.8),
          child: child,
        ),
      ),
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
