import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
class FilledForm extends StatefulWidget {
  final FirebaseUser user;
  FilledForm({Key key,@required this.user}): super(key:key);
  @override
  _FilledFormState createState() => _FilledFormState(user);
}

class _FilledFormState extends State<FilledForm> {
  final FirebaseUser user;
  _FilledFormState(this.user);
  String _userName;
  String _trainingInstituteName;
  DateTime _joiningDate;
  String _trainingType;
  String _semeseter;
  String _rollNumber;
  static  DateTime current = DateTime.now();
  final String _todayDate = " " + current.day.toString() + "/" + current.month.toString() + "/" + current.year.toString();



  @override
  Widget build(BuildContext context) {
    
    String html = '''
        
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><META http-equiv="Content-Type" content="text/html; charset=utf-8"></head><body>

	
		  
		
	
	<div align="center">
		
			<br><br>
			<div>
					<img src="https://source.unsplash.com/random/300x200" height="100px" width="100px" alt="logo" border="0">
					<h4 align="center">
					UNIVERSITY INSTITUTE OF ENGINEERING &amp; TECHNOLOGY<br>
					(A Constituent Autonomous Institute and Recognized by UGC Under Section 12 (B) &amp; 2 (f))
					KURUKSHETRA UNIVERSITY KURUKSHETRA
					(Established by the State Legislature Act XII of 1956)
					(&#39;A+&#39; Grade, NAAC Accredited)
					</h4>
			</div>
		
		<hr color="blue"><br>
		<div align="right">
			<p>No. UIET/___/_______</p>
			<p>Dated<b><u>$_todayDate</u></b></p>
		</div><br>
		
			<p>To<br>
			<b><u>$_trainingInstituteName</u></b><br>
			<u><b>Kohat Enclave</b></u><br>
			<u><b>New Delhi, India</b></u><br>
			</p>
			<h4>Subject:Request for Industrial Training for B.Tech <b><u>$_semeseter Semester</u></b> for 4/6 weeks.</h4>
			<p>Dear Sir/Madam,<br><br>
			We are pleased to introduce UIET, a constituent Autonomous Institute of Kurukshetra University, Kurukshetra.
			The institute is situated in the lush green campus of KUK. The Kurukshetra University is a premier university 
			of Haryana, established in the year 1956. It has been accredited &#39;A+&#39; grade by NAAC. Currently the institute is
			running four B. Tech. and six M. Tech courses in Computer Science and Engineering, Electronics and Communication
			Engineering, Mechanical Engineering and Biotechnology. I would like to bring to your knowledge that our students
			are among the top rankers of Haryana. Admission to our institute is through IIT JEE rank in B. Tech and through
			GATE Score and University Entrance test in M. Tech. In the field of Research and Development few students are
			also enrolled for their PhD.<br><br>
			As a part of the curriculum, B.Tech. students are required to undergo industrial training. This on-site practical
			exposure in their respective areas will not only give them the confidence of applying the theory learnt during
			academics in practical shape but will also show them how to handle the operations practically. It will also help
			them developing into perfect engineers under the expert guidance of your experts.<br><br>
			I therefore request you to kindly permit and make necessary arrangements for training for <b>
			Mr./Ms <u>$_userName</u>
			Roll No.<u>$_rollNumber</u></b> a student of B. Tech (<b><u>$_semeseter</u></b>) semester of this institute from __________ to __________ at
			your esteemed organization.  
			We shall be ever thankful to you for your kindness in making his/her career successful.<br>
			Thanking you in anticipation.<br>
			Yours sincerely,<br><br>
			Convener<br>
			Training and Placement Cell,<br>
			University Institute of Engineering and Technology,<br>
			Kurukshetra University, Kurukshetra<br>
			E-mail: <a href="mailto:tpouiet@kuk.ac.in" target="_blank">tpouiet@kuk.ac.in</a><br>
			Contact: +91-9729999805<br></p>
		
		
		
	</div>
</body></html>

      ''';
    return MaterialApp(
      home: new Scaffold(
        body:  new StreamBuilder(
          stream: Firestore.instance.collection("TrainingForms").where('email',isEqualTo: user.email.toString()).snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) return new Center(child: new CircularProgressIndicator(backgroundColor: Colors.black));
            print("Yaar Hooja ${snapshot.data.documents.length}");
            print("meri email ${snapshot.data.documents[0].data['name']}");
            _userName = snapshot.data.documents[0].data['name'];
            print(_userName);
            _trainingInstituteName = snapshot.data.documents[0].data['TrainingInstituteName'];
            _semeseter = snapshot.data.documents[0].data['Semester'];
            _rollNumber = snapshot.data.documents[0].data['rollNumber'];

            return new SingleChildScrollView(
              child: new Center(
                child: new HtmlView(
                  data: html,
                ),
              ),
            );
          },
        )
      ),
    );
  }
}