import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InteractionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InteractionPageState();
  }
}

class InteractionPageState extends State<InteractionPage>
    with InputValidationMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController yourSelfController = TextEditingController();

  List<String> countries = ["Россия", "Германия", "Польша", "Шатландия"];
  late String selectedCountry;
  bool visiblePassword = true;

  final formKey = GlobalKey<FormState>();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    yourSelfController.dispose();

    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  void focusChange (BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Взаимодействие",
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                "Форма",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                focusNode: nameFocus,
                autofocus: true,
                onFieldSubmitted: (_){
                  focusChange(context,nameFocus,phoneFocus);
                },
                controller: nameController,
                validator: (val) {
                  if (!isNameValid(val!)) {
                    return 'Поле пустое или некорректно заполнено';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Фамилия и имя",
                  hintText: "Иванов Иван",
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    splashRadius: 20,
                    onPressed: () {
                      nameController.clear();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                focusNode: phoneFocus,
                onFieldSubmitted: (_){
                  focusChange(context,phoneFocus,emailFocus);
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [maskFormatter],
                controller: phoneController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Номер телефона",
                  hintText: "+7-(XXX)-XXX-XX-XX",
                  helperText: "Формат: +7-(XXX)-XXX-XX-XX",
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    splashRadius: 20,
                    onPressed: () {
                      phoneController.clear();
                    },
                  ),
                ),
                validator: (val) {
                  if (!isPhoneValid(val!)) {
                    return 'Некорректные данные';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                focusNode: emailFocus,
                onFieldSubmitted: (_){
                  focusChange(context,emailFocus,passwordFocus);
                },
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "E-mail",
                  hintText: "Введите E-mail",
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    splashRadius: 20,
                    onPressed: () {
                      emailController.clear();
                    },
                  ),
                ),
                validator: (val) {
                  if (!isEmailValid(val!)) {
                    return 'Некорректные данные';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: "Выберите страну..."),
                items: countries.map((country) {
                  return DropdownMenuItem(
                      child: Text("$country"), value: country);
                }).toList(),
                onChanged: (data) {
                  print(data);
                  setState(() {
                    selectedCountry = data.toString();
                  });
                },
                validator: (val) {

                  return val == null? "Выберите страну" : null;
                }
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                maxLines: 3,
                maxLength: 225,
                controller: yourSelfController,
                decoration: InputDecoration(
                  //alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "О себе",
                  hintText: "Расскажите о себе",
                  prefixIcon: Icon(Icons.message),
                  suffix: IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.topRight,
                    icon: Icon(Icons.clear),
                    splashRadius: 20,
                    onPressed: () {
                      yourSelfController.clear();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                focusNode: passwordFocus,
                controller: passwordController,
                obscureText: visiblePassword,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Пароль",
                  hintText: "Введите пароль",
                  prefixIcon: Icon(Icons.security),
                  suffixIcon: IconButton(
                    icon: Icon(visiblePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    splashRadius: 20,
                    onPressed: () {
                      setState(() {
                        visiblePassword = !visiblePassword;
                      });
                    },
                  ),
                ),
                validator: (val) => validatePassoword(val),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: visiblePassword,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Подтверждение пароля",
                  hintText: "Введите пароль ещё раз",
                  prefixIcon: Icon(Icons.security_outlined),
                ),
                validator: (val) => validatePassoword(val),
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                  child: Text(
                    "Отправить",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  color: Colors.deepOrange,
                  onPressed: () {
                    setState(() {
                      submitForm();
                    });
                  }),
            ],
          ),
        ));
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      print("Форма заполнена отправлена:");
      print("Имя Фамилия: ${nameController.text}");
      print("Телефон: ${phoneController.text}");
      print("E-mail: ${emailController.text}");
      print("Страна: $selectedCountry");
      print("О себе: ${yourSelfController.text}");
      print("Пароль: ${passwordController.text}");
    } else {
      print("Форма заполнена неверно");
    }
  }

  String? validatePassoword(String? val) {
    if (passwordController.text.length < 8) {
      return 'Пароль должен быть длинее 8 символов';
    } else if (confirmPasswordController.text != passwordController.text) {
      return 'Пароли не совпадают';
    } else {
      return null;
    }
  }
}

mixin InputValidationMixin {

  bool isEmailValid(String email) {
    final regular = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regular.hasMatch(email);
  }

  bool isNameValid(String name) {
    final regular =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return regular.hasMatch(name);
  }

  bool isPhoneValid(String phone) {
    final regular = RegExp(r'^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$');
    return regular.hasMatch(phone);
  }
}
