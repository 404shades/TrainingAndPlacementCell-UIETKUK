import 'package:flutter/material.dart';
import 'package:training_placement/Companies.dart';

class RecruitersWidget extends StatefulWidget {
  @override
  _RecruitersWidgetState createState() => _RecruitersWidgetState();
}

class _RecruitersWidgetState extends State<RecruitersWidget> {

  Widget bodyData()=> DataTable(

    sortColumnIndex: 0,
    
    columns: <DataColumn>[
      DataColumn(
        label: new Text("Company Name"),
        numeric: false,
        tooltip: "To display Companies Icons",

      ),
      DataColumn(
        label: new Text("Package Offered"),
        numeric: false,
        tooltip: "To display Companies Name",

      ),
      
      
    ],
    rows: copanies.map((company)=>DataRow(
      selected: true,
      cells: [
        DataCell(Text(company.name)),
        DataCell(Text(company.packageOffered))
      ]
    )).toList(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Our Recruiters",style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w500),),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          
          child: Center(
            
            child: Card(
            
            child: bodyData(),
          ),
          )
        ),
      )
    );
  }
}

var copanies = <Recruiters>[
  Recruiters(
    
    name: "Infosys",
    packageOffered: "Rs 3.25 lpa",
    studentsPlaced: 28
  ),
  Recruiters(
   
    name: "Adani Gas Ltd.",
    packageOffered: "Rs. 4.5 lpa",
    studentsPlaced: 5
  ),
  Recruiters(
    
    name: "Wipro Technologies",
    packageOffered: "Rs 3.25 lpa",
    studentsPlaced: 12
  ),
  Recruiters(
    
    name: "IBM India Pvt. Ltd.",
    packageOffered: "Rs 3.25 lpa",
    studentsPlaced: 8
  ),
  Recruiters(
    
    name: "Byjus Pvt. Ltd.",
    packageOffered: "Rs 4.5 lpa",
    studentsPlaced: 1
  ),
  Recruiters(
    
    name: "Daikin AC",
    packageOffered: "Rs 5.5 lpa",
    studentsPlaced: 1

  ),
  Recruiters(
   
    name: "British Telecom",
    packageOffered: "Rs 3.6 lpa",
    studentsPlaced: 4

  ),
  Recruiters(
   
    name: "Samsung",
    packageOffered: "Rs 4.3 lpa",
    studentsPlaced: 3

  ),
  Recruiters(
    
    name: "VIVO Mobile",
    packageOffered: "Rs 3.5 lpa",
    studentsPlaced: 1

  ),
  Recruiters(
    
    name: "Cryptographics IT Sol.",
    packageOffered: "Rs 3.25 lpa",
    studentsPlaced: 1

  ),
  Recruiters(
    
    name: "IDS INFOTECH",
    packageOffered: "Rs 3.5 lpa",
    studentsPlaced: 1

  ),
  Recruiters(
    
    name: "SAIFINTEX",
    packageOffered: "Rs 3 lpa",
    studentsPlaced: 1

  ),
 
  Recruiters(
    
    name: "Talent Pull",
    packageOffered: "Rs 2.4 lpa",
    studentsPlaced: 1

  ),
  Recruiters(
    name: "Panacea Biotec",
    packageOffered: "Rs 2 lpa",
    studentsPlaced: 1

  ),
  
];