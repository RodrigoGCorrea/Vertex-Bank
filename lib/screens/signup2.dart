import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/signUp/cancelButton.dart';
import 'package:vertexbank/components/vtx_gradient.dart';

class SignUp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _lastnameController = TextEditingController();
    final _cpasswordController = TextEditingController();
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: VtxSizeConfig.screenHeight * 0.11,
                width: VtxSizeConfig.screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(14),
                  ),
                  child: BackButton(),
                ),
              ),
              HeaderSignUp2(),
              SizedBox(height: getProportionateScreenHeight(35)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(52)),
                child: VtxTextBox(
                  text: "Name",
                  controller: _nameController,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(52)),
                child: VtxTextBox(
                  text: "Last name",
                  controller: _lastnameController,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(52)),
                child: BasicDateField(),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              VtxButton(
                text: "Finish",
                function: () => {},
              ),
              SizedBox(
                height: getProportionateScreenHeight(13),
              ),
              Text(
                "or",
                style: TextStyle(color: AppTheme.textColor),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              CancelButton(),
              SizedBox(
                height: VtxSizeConfig.screenHeight * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/chevron-left-solid.svg",
            width: getProportionateScreenWidth(10),
            color: AppTheme.textColor,
          ),
          SizedBox(
            width: getProportionateScreenWidth(4),
          ),
          Text(
            "back",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(10),
              color: AppTheme.textColor,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderSignUp2 extends StatelessWidget {
  const HeaderSignUp2({
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

class Background extends StatelessWidget {
  final Widget child;

  const Background({
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

class BasicDateField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      resetIcon: null,
      style: TextStyle(
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
