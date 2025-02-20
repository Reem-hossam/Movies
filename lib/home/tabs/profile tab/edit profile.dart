import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName="UpdateProfileScreen";
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  List<String> avatars = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar4.png",
    "assets/images/avatar5.png",
    "assets/images/avatar6.png",
    "assets/images/avatar7.png",
    "assets/images/avatar8.png",
    "assets/images/avatar9.png",
  ];
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  String selectedAvatar = "assets/images/avatar1.png";
  void AvatarSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Color.fromRGBO(40, 42, 40, 1),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(19),
          child:
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 19,
                  mainAxisSpacing: 17,
                ),
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatar = avatars[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedAvatar ==avatars[index]?Color.fromRGBO(246, 189, 0, 0.56)
                            : Colors.transparent,
                        border: Border.all(
                          color: Color.fromRGBO(246, 189, 0, 1),
                          width:1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(avatars[index]),
                    ),
                  );
                },
              ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Avatar",style:TextStyle(color:Colors.yellow),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(

          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => AvatarSelection(context),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(selectedAvatar),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person,color: Theme.of(context).inputDecorationTheme.iconColor,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone,color: Theme.of(context).inputDecorationTheme.iconColor,),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Reset Password",style: Theme.of(context).textTheme.bodyMedium,),
            ),
            SizedBox(height:150),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: Text("Delete Account",style:Theme.of(context).textTheme.bodyMedium,),
            ),
            SizedBox(height:20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(

                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: Text("Update Data",),
            )
        ]
        ),
      ),

    );
  }
}