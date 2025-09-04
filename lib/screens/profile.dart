// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final FirebaseService _firebaseService = FirebaseService();
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController nameController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController professionController = TextEditingController();

//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }

//   void _loadProfile() async {
//     final doc = await _firebaseService.getUserProfile();
//     if (doc != null && doc.exists) {
//       final data = doc.data();
//       nameController.text = data?['name'] ?? '';
//       ageController.text = data?['age'] ?? '';
//       genderController.text = data?['gender'] ?? '';
//       professionController.text = data?['profession'] ?? '';
//     }
//     setState(() => isLoading = false);
//   }

//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       await _firebaseService.saveUserProfile({
//         'name': nameController.text,
//         'age': ageController.text,
//         'gender': genderController.text,
//         'profession': professionController.text,
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile saved")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) return Center(child: CircularProgressIndicator());

//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
//               TextFormField(controller: ageController, decoration: InputDecoration(labelText: "Age"), keyboardType: TextInputType.number),
//               TextFormField(controller: genderController, decoration: InputDecoration(labelText: "Gender")),
//               TextFormField(controller: professionController, decoration: InputDecoration(labelText: "Profession")),
//               SizedBox(height: 20),
//               ElevatedButton(onPressed: _saveProfile, child: Text("Save")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _professionController = TextEditingController();

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: FutureBuilder<DocumentSnapshot>(
        future: docRef.get(),
        builder: (context, snapshot) {
          // While loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // If no data exists → show form to enter new profile
          if (!snapshot.hasData || !snapshot.data!.exists || _isEditing) {
            return _buildProfileForm(docRef);
          }

          // If data exists → show profile
          var data = snapshot.data!.data() as Map<String, dynamic>;
          return _buildProfileView(data, docRef);
        },
      ),
    );
  }

  Widget _buildProfileForm(DocumentReference docRef) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _genderController,
              decoration: InputDecoration(labelText: "Gender"),
            ),
            TextFormField(
              controller: _professionController,
              decoration: InputDecoration(labelText: "Profession"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await docRef.set({
                  "name": _nameController.text,
                  "age": _ageController.text,
                  "gender": _genderController.text,
                  "profession": _professionController.text,
                });
                setState(() {
                  _isEditing = false;
                });
              },
              child: Text("Save Profile"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileView(Map<String, dynamic> data, DocumentReference docRef) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: ${data['name'] ?? ''}"),
          Text("Age: ${data['age'] ?? ''}"),
          Text("Gender: ${data['gender'] ?? ''}"),
          Text("Profession: ${data['profession'] ?? ''}"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _nameController.text = data['name'] ?? '';
              _ageController.text = data['age'] ?? '';
              _genderController.text = data['gender'] ?? '';
              _professionController.text = data['profession'] ?? '';
              setState(() {
                _isEditing = true;
              });
            },
            child: Text("Edit Profile"),
          )
        ],
      ),
    );
  }
}
