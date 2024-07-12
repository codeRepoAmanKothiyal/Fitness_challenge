import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FitnesChallange extends StatefulWidget {
  const FitnesChallange({super.key});

  @override
  State<FitnesChallange> createState() => _FitnesChallangeState();
}

class _FitnesChallangeState extends State<FitnesChallange> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  var _gender = ["Male", "Female"];
  var _currentItemSelected = "Male";

  String? _nameErrorText ;
  String? _ageErrorText;
  String? _daysErrorText;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Fitness Challenge",
            style: TextStyle(fontSize: 25))
        ),
        backgroundColor: Color(0xFFEF4040),
      ),
      body: Container(
        color: Color(0xFF711DB0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                validator: (value) => _nameErrorText,
                onChanged: _validateName,
                decoration: InputDecoration(
                    labelText: 'Your Name.',
                    hintText: "Enter Your Name e.g :Aman",
                    filled: true,
                    errorText: _nameErrorText,
                    fillColor: Color(0xffFFA732),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) => _ageErrorText,
                      controller: ageController,
                      onChanged: _validateAge,
                      decoration: InputDecoration(
                          labelText: 'Your Age.',
                          hintText: "Age in number e.g :1-50",
                          filled: true,
                          errorText: _ageErrorText,
                          fillColor: Color(0xffFFA732),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                    child: DropdownButton<String>(
                      items: _gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (newValueSelected) {
                        _onDropDownItemSelected(newValueSelected);
                      },
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: daysController,
                      validator: (value) => _daysErrorText,
                      onChanged: _validateDays,

                      decoration: InputDecoration(
                          labelText: 'No of Days.',
                          hintText: "Enter no of days e.g :1-30",
                          filled: true,
                          errorText: _daysErrorText,
                          fillColor: Color(0xffFFA732),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){
                    showToast(
                        context: context,
                        _calculateFitness(), backgroundColor: Color(0xffC21292),
                      // animation: StyledToastAnimation.slideFromBottom,
                      // reverseAnimation: StyledToastAnimation.fade,
                      position: StyledToastPosition.center,
                   //   animDuration: Duration(seconds: 1),
                      duration: Duration(seconds: 7),

                    );
                   /* Fluttertoast.showToast(msg: _calculateFitness(),
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                        // toastLength: Toast.LENGTH_LONG,
                        // gravity: ToastGravity.TOP,
                        // backgroundColor: Colors.deepOrange,// Color(0xffC21292),
                        // textColor: Colors.white
                    );*/

                  },
                    child: Text("Calculate"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC21292),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),

                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void _onDropDownItemSelected(newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateFitness() {
   // print('${ageController.value.text}');
    int age = int.parse(ageController.value.text);
    int days = int.parse(daysController.value.text);
    String name = nameController.text;
    String? performance ;

    if (age>=18 && age<=30){
      if(_currentItemSelected== "Male" && (days>=25)){
        performance="Excellent fitness";
      }else if (_currentItemSelected== "Male" && (days<25)){
        performance="Good";
      }else if (_currentItemSelected== "Female" && (days>=20)){
        performance="Excellent fitness";
      }else{
        performance="Good";
      }
    }else if(age>=31 && age<=50){
      if(_currentItemSelected== "Male" && days>=20){
        performance="Excellent fitness";
      }else if (_currentItemSelected== "Male" && days<20){
        performance="Good";
      }else if (_currentItemSelected== "Female" && days>=15){
        performance="Excellent fitness";
      }else{
        performance="Good";
      }
    }if (age>=51){
      if(_currentItemSelected== "Male" && days>=15){
        performance="Excellent fitness";
      }else if (_currentItemSelected== "Male" && days<15){
        performance="Good";
      }else if (_currentItemSelected== "Female" && days>=10){
        performance="Excellent fitness";
      }else{
        performance="Good";
      }
    }

    String result =
        "your namer is ${name} and your are $age and your fitness is $performance ";
    return result;
  }

  // Name Validation
  void _validateName(String value) {
    if (value.isEmpty) {
      setState(() {
        _nameErrorText = 'Name is required';
      });
    } else if (!isNameValid(value)) {
      setState(() {
        _nameErrorText = 'Enter a valid name';
      });
    } else {
      setState(() {
        _nameErrorText = null;
      });
    }
  }

  bool isNameValid(String name) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^[a-zA-Z]+$').hasMatch(name);
  }


  // Function for Validation of age should be less then & = 100
  void _validateAge(String value) {
    if (value.isEmpty) {
      setState(() {
        _ageErrorText = 'Age is required';
      });
    } else if (!isAgeValid(value)) {
      setState(() {
        _ageErrorText = 'Enter a valid age <= 100';
      });
    } else {
      setState(() {
        _ageErrorText = null;
      });
    }
  }

  bool isAgeValid(String age) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^(0?[1-9]|[1-9][0-9]|[1][1-9][1-9]|100)$').hasMatch(age);
  }


  void _validateDays(String value) {
    if (value.isEmpty) {
      setState(() {
        _daysErrorText = 'Days are required to Calculate';
      });
    } else if (!isDaysValid(value)) {
      setState(() {
        _daysErrorText = 'Enter a valid days of in Month <= 31';
      });
    } else {
      setState(() {
        _daysErrorText = null;
      });
    }
  }

  bool isDaysValid(String day) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^0[1-9]|[12]\d|3[01]$').hasMatch(day);
  }

}
