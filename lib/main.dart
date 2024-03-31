import 'dart:math';

import 'package:bloc_example/bloc/auth_bloc.dart';
import 'package:bloc_example/model.dart';
import 'package:bloc_example/photo_model.dart';
import 'package:bloc_example/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(
    
    BlocProvider(
     create: (context) => AuthBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHome(),
    );
  }
}



class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFail)
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.Error)));
        else if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => UserHome(
                        email: state.email,
                      )),
              (route) => false);
        }
        //debugPrint();
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: AnimatedAlign(
              alignment: Alignment.bottomCenter,
              duration: Duration(milliseconds: 1000),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0,end: 1),
                    builder: (context, value, child) => AnimatedOpacity(
                      opacity: value,
                      duration: Duration(milliseconds: 1000),
                      child: FlutterLogo(size: 45,)),
                    duration: Duration(seconds: 1),
                    ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'Enter email'),
                  ),
                  TextField(
                    controller: passController,
                    decoration: InputDecoration(hintText: 'Enter password'),
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLoginRequested(UserModel(
                            emailController.text, passController.text)));
                      },
                      child: Text('Click'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


class UserHome extends StatefulWidget {
  final String email;
  UserHome({super.key, required this.email});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {


  @override
  void initState() {
    
    super.initState();
    



  }
Future<List<Photo>> getusers()async{
UserRepository repo=UserRepository();

return await repo.getUsers();
}

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthInitial)
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyHome()), (route) => false);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(widget.email),
        Expanded(
          child: FutureBuilder(
          future: getusers(),
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.done){
        print(snapshot.data.toString());
            }
        if(!snapshot.hasData) return CircularProgressIndicator();
        
        
            return GridView.builder(
        itemCount: snapshot.data?.length,
        
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
         itemBuilder: (context,index){
          return  Image.network(snapshot.data?[index].url)
          ;
         });
          }
        )),
        
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogOutREequested());
                  },
                  child: Text('Sign out'))
            ],
          ),
        ),
      ),
    );
  }
} 
