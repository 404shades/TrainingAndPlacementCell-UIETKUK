class Users{
  String _name;
  String _rollNumber;
  String _email;
  String _datOfBirth;
  String _class10RollNumber;
  String _class12RollNumber;
  String _class10Marks;
  String _class12Marks;
  String _mobileNumber;
  Users(this._name,this._rollNumber,this._email,this._class10Marks,this._class10RollNumber,this._class12Marks,this._class12RollNumber,this._datOfBirth,this._mobileNumber);

  String getName(){
    return _name;
  }
  String getRollNumber(){
    return _rollNumber;
  }
  String getEmail(){
    return _email;
  }
  String getDateOfBirth(){
    return _datOfBirth;
  }
  String getClass10RollNumber(){
    return _class10RollNumber;
  }
  String getClass12RollNumber(){
    return _class12RollNumber;
  }
  String getClass10Marks(){
    return _class10Marks;
  }
  String getClass12Marks(){
    return _class12Marks;
  }
  String getMobileNumber(){
    return _mobileNumber;
  }

}