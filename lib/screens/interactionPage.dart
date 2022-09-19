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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _yourSelfController = TextEditingController();

  List<String> _countries = ["Россия", "Германия", "Польша", "Шатландия"];
  late String _selectedCountry;
  bool _visiblePassword = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _yourSelfController.dispose();

    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

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
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Взаимодействие",
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
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

                focusNode: _nameFocus,
                autofocus: true,
                onFieldSubmitted: (_){
                  focusChange(context,_nameFocus,_phoneFocus);
                },
                controller: _nameController,
                validator: (val) {
                  if (!isNameValid(val!)) {
                    return 'Поле пустое или некорректно заполнено';
                  } else {
                    return null;
                  }
                },
                decoration:  InputDecoration(
                  isDense: true,
                  errorBorder: const OutlineInputBorder(
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
                  suffix:   GestureDetector(
                    onTap: (){
                      _nameController.clear();
                    },
                      child: Icon(Icons.delete_outline,color: Colors.red,
                      ))
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                focusNode: _phoneFocus,
                onFieldSubmitted: (_){
                  focusChange(context,_phoneFocus,_emailFocus);
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [maskFormatter],
                controller: _phoneController,
                decoration: InputDecoration(
                    isDense: true,
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
                    suffix:   GestureDetector(
                        onTap: (){
                          _phoneController.clear();
                        },
                        child: Icon(Icons.delete_outline,color: Colors.red,
                        ))
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
                focusNode: _emailFocus,
                onFieldSubmitted: (_){
                  focusChange(context,_emailFocus,_passwordFocus);
                },
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                    isDense: true,
                  enabledBorder: OutlineInputBorder(

                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "E-mail",
                  hintText: "Введите E-mail",
                  prefixIcon: Icon(Icons.email),
                    suffix:   GestureDetector(
                        onTap: (){
                          _emailController.clear();
                        },
                        child: Icon(Icons.delete_outline,color: Colors.red,
                        ))
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
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: "Выберите страну..."),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                      child: Text("$country"), value: country);
                }).toList(),
                onChanged: (data) {
                  print(data);
                  setState(() {
                    _selectedCountry = data.toString();
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
                controller: _yourSelfController,
                decoration: InputDecoration(
                    isDense: true,
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
                    suffix:   GestureDetector(
                        onTap: (){
                          _yourSelfController.clear();
                        },
                        child: Icon(Icons.delete_outline,color: Colors.red,
                        ))
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                focusNode: _passwordFocus,
                controller: _passwordController,
                obscureText: _visiblePassword,
                decoration: InputDecoration(
                  isDense: true,
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
                    icon: Icon(_visiblePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    splashRadius: 20,
                    onPressed: () {
                      setState(() {
                        _visiblePassword = !_visiblePassword;
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
                controller: _confirmPasswordController,
                obscureText: _visiblePassword,
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showMassage(message: "Форма успешно заполнена!", color: Colors.green);
      print("Форма заполнена отправлена:");
      print("Имя Фамилия: ${_nameController.text}");
      print("Телефон: ${_phoneController.text}");
      print("E-mail: ${_emailController.text}");
      print("Страна: $_selectedCountry");
      print("О себе: ${_yourSelfController.text}");
      print("Пароль: ${_passwordController.text}");
    } else {
      _showMassage(message: "Форма заполнена неверно", color: Colors.red);
      print("Форма заполнена неверно");
    }
  }

  String? validatePassoword(String? val) {
    if (_passwordController.text.length < 8) {
      return 'Пароль должен быть длинее 8 символов';
    } else if (_confirmPasswordController.text != _passwordController.text) {
      return 'Пароли не совпадают';
    } else {
      return null;
    }
  }

  void _showMassage ( { required String message, required Color color}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
        elevation: 30,
        duration: Duration(seconds: 4),
        backgroundColor: color,
          content: Text("$message"))
    );
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
