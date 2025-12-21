
import 'package:flutter/material.dart';
import 'SignIn.dart';
import 'SignUp.dart';
import 'package:demo_app_2/Auth/authservice.dart';
import 'profile_screen.dart';


class profileForAuth extends StatelessWidget {
  const profileForAuth({super.key});


  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final as = AuthService();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void SignIn()async{
      final email = emailController.text;
      final password = passwordController.text;
      try{
        await as.signInWithEmailAndPassword(email, password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Success"),
          backgroundColor: Colors.green,
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString(),
          ),
          backgroundColor: Colors.red,
        )
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: screenHeight*0.1,
              backgroundColor: Colors.purple,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.trending_up_rounded, color: Color(0xFF8B5CF6)),
                    const SizedBox(width: 8),
                    Text("Trend Evlauator",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: screenHeight*0.15,),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person,),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Enter Your Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Enter Your Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                      ElevatedButton(onPressed: (){
                       SignIn();
                      },
                        child: Text("SignIn"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                  }, child:
                      Text("SignUp"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
