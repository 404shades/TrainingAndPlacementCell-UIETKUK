class Users{
  String _name;
  int _rollNumber;
  String _email;
  String _datOfBirth;
  int _class10RollNumber;
  int _class12RollNumber;
  double _class10Marks;
  double _class12Marks;
  String _mobileNumber;
  Users(this._name,this._rollNumber,this._email,this._class10Marks,this._class10RollNumber,this._class12Marks,this._class12RollNumber,this._datOfBirth,this._mobileNumber);

  String getName(){
    return _name;
  }
  int getRollNumber(){
    return _rollNumber;
  }
  String getEmail(){
    return _email;
  }
  String getDateOfBirth(){
    return _datOfBirth;
  }
  int getClass10RollNumber(){
    return _class10RollNumber;
  }
  int getClass12RollNumber(){
    return _class12RollNumber;
  }
  double getClass10Marks(){
    return _class10Marks;
  }
  double getClass12Marks(){
    return _class12Marks;
  }
  String getMobileNumber(){
    return _mobileNumber;
  }

}