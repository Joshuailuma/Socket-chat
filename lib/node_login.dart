import 'package:first_app/internet.dart';
import 'package:first_app/socket_chat.dart';
import 'package:flutter/material.dart';

class NodeLogin extends StatefulWidget {
  NodeLogin({Key? key}) : super(key: key);

  @override
  State<NodeLogin> createState() => _NodeLoginState();
}

class _NodeLoginState extends State<NodeLogin> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  // Future? internetModel;

  @override
  void initState() {
    super.initState();
  }

  submit() async {
    setState(() {
      isLoading = true;
    });
    if (emailController.text.length >= 2 &&
        passwordController.text.length >= 6) {
      String token = await InternetManager().fetchData(
          nameController.text, emailController.text, passwordController.text);
      if (token.length > 30) {
        // save token in shared preference

        setState(() {
          isLoading = false;
        });

        Navigator.push(
            (context), MaterialPageRoute(builder: (builder) => SocketChat()));
      } else {
        print('Internet model probs');
        setState(() {
          isLoading = false;
        });

        return showAlertDialog(token);
      }
    } else {
      setState(() {
        isLoading = false;
      });

      return showAlertDialog('Email or password too short');
      //A dialog show right email and password
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                strokeWidth: 4.5,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   icon: Icon(Icons.arrow_back_ios),
              // ),
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Text('Login'),
            ),
            body: Column(
              children: [
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Container(
                //     padding: EdgeInsets.all(8),
                //     margin: EdgeInsets.symmetric(horizontal: 20),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //           offset: Offset(0, 10),
                //           blurRadius: 20,
                //           color: kPrimaryColor.withOpacity(0.5),
                //         )
                //       ],
                //     ),
                //     child: TextFormField(
                //       controller: nameController,
                //       autovalidateMode: AutovalidateMode.onUserInteraction,
                //       keyboardType: TextInputType.name,
                //       validator: (value) {
                //         if (value == null || value.trim().length < 2) {
                //           return 'Name must be longer than 2 letters.';
                //         } else if (value.length > 25) {
                //           return 'Name too long';
                //         }

                //         return null; //else return null
                //       },
                //       textCapitalization: TextCapitalization.words,
                //       decoration: InputDecoration(
                //         border: InputBorder.none,
                //         hintText: 'Name',
                //         hintStyle: TextStyle(
                //           color: Colors.blue.withOpacity(0.5),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 20,
                          color: Colors.yellowAccent.withOpacity(0.5),
                        )
                      ],
                    ),
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().length < 5) {
                          return 'Email must be longer than 5 letters.';
                        } else if (value.length > 25) {
                          return 'Email too long';
                        }

                        return null; //else return null
                      },
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.blue.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 20,
                          color: Colors.blueGrey.withOpacity(0.5),
                        )
                      ],
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.trim().length < 5) {
                          return 'Password must be longer than 6 characters.';
                        } else if (value.length > 20) {
                          return 'Password too long';
                        }

                        return null; //else return null
                      },
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.blue.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    submit();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color(0xFFB93B8F),
                        Color(0xFFE3319D),
                        Color(0xFFFF00FF),
                      ]),
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                // (internetModel == null) ? Text('HI') : buildFutureBuilder()
              ],
            ),
          );
  }

  showAlertDialog(
    String message,
  ) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok')),
          ],
        );
      },
    );
    // FutureBuilder buildFutureBuilder() {
    //   return FutureBuilder(
    //     future: internetModel,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return Text(snapshot.data);
    //       } else if (snapshot.hasError) {
    //         return Text('${snapshot.error}');
    //       }

    //       return const CircularProgressIndicator();
    //     },
    //   );
  }
}
