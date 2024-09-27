import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              SizedBox(height: 20),

              // User Name and Email
              Text(
                'Nanndish', // User's name
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'nanndish@gmail.com', // User's email
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),

              // Mobile Form for editing profile details (name, email, phone)
              Form(
                child: Column(
                  children: [
                    // Text Field for Name (Text Input)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: 'Nanndish',
                    ),
                    SizedBox(height: 20),

                    // Text Field for Email (Email Input)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      initialValue: 'nanndish@gmail.com',
                    ),
                    SizedBox(height: 20),

                    // Text Field for Phone Number (Phone Input)
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      initialValue: '077 989 9845',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Edit Profile Button
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Edit Profile clicked'),
                  ));
                },
                icon: Icon(Icons.edit),
                label: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.red, // Button background color
                ),
              ),
              SizedBox(height: 30),

              // Divider
              Divider(thickness: 2),

              // Account Details Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Account Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Username'),
                subtitle: Text('nanndish01'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text('nanndish@gmail.com'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone Number'),
                subtitle: Text('077 989 9845'),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Address'),
                subtitle: Text('No. 388 Union Pl, Colombo 00200'),
              ),
              SizedBox(height: 30),

              // Settings Section
              Divider(thickness: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Change Password clicked'),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notification Settings'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Notification Settings clicked'),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy Settings'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Privacy Settings clicked'),
                  ));
                },
              ),
              SizedBox(height: 30),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Logging out...'),
                  ));
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button background color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
