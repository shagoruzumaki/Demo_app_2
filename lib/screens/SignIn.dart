import 'package:flutter/material.dart';
import 'package:demo_app_2/Auth/authservice.dart';
import 'profile_screen.dart';



class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
              expandedHeight: screenHeight*0.2,
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
              child: SizedBox(height: screenHeight*0.25,),
            ),
          ],

        ),
      ),
    );
  }
}
