import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_fert/screens/home.dart';
import 'package:smart_fert/utils/theme/constants/sizes.dart';

import '../common/widgets/spacing_style.dart';
import '../utils/theme/constants/colors.dart';
import '../utils/theme/constants/text_strings.dart';
import '../utils/theme/helper_functions/helper_functions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController pass = TextEditingController();
  TextEditingController userName = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: const Color(0xFF70BE92),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // This will dismiss the keyboard
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: ESpacingStyle.paddingWithAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: ESizes.spaceBtwSections,
                ),
                const SizedBox(
                  child: Column(
                    children: [
                      Image(
                        height: 150,
                        image: AssetImage('assets/images/CROP2.png'),
                      ),
                    ],
                  ),
                ),
                const Text(
                  ETexts.loginTitle,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white70),
                  //style: TextStyle(color: Colors.black, fontSize: 45),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  ETexts.loginSubTitle,
                  // style: Theme.of(context).textTheme.bodyMedium,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
                  //style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                const SizedBox(
                  height: ESizes.spaceBtwSections,
                ),

                TextField(
                  controller: userName,
                  cursorColor: Colors.white70,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600), // Text color for better contrast
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent.withOpacity(0.15), // Slightly darker green to make it stand out
                    prefixIcon: const Icon(
                      Iconsax.direct_right,
                      color: Colors.white, // White icon for contrast
                    ),
                    labelText: ETexts.username,
                    labelStyle: const TextStyle(color: Colors.white60, fontSize: 16, fontWeight: FontWeight.w600), // Lighten and adjust the label text color
                    floatingLabelBehavior: FloatingLabelBehavior.auto, // Smooth transition effect for the label
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2.0), // White border when focused
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.6), width: 1.5), // Semi-transparent white border when not focused
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.red, width: 2.0), // Red border for errors
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    hintText: '',
                    hintStyle: const TextStyle(color: Colors.white60), // Subtle hint text color
                    contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0), // Adjust padding
                  ),
                ),


                const SizedBox(
                  height: ESizes.spaceBtwInputFields,
                ),

                TextField(
                  controller: pass,
                  cursorColor: Colors.white70,
                  obscureText: _obscureText, // For hiding the password input
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:Colors.transparent.withOpacity(0.15),
                    prefixIcon: const Icon(
                      Iconsax.password_check,
                      color: Colors.white,
                    ),
                    labelText: ETexts.password,
                    labelStyle: const TextStyle(color: Colors.white60, fontSize: 16, fontWeight: FontWeight.w600),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.6), width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    hintText: '',
                    hintStyle: const TextStyle(color: Colors.white60),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70, // Change the color if needed
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // Toggle visibility
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Forgot Password
                    TextButton(
                      onPressed: () {},
                      child: const Text(ETexts.forgetPassword, style: TextStyle(color: Colors.purple),),
                    ),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()),
                      );
                    },
                    child: const Text(
                      "Sign in",
                    ),
                  ),
                ),
                // OutlinedButton(onPressed: (){}, child: Text('Login',style: Theme.of(context)
                //     .textTheme
                //     .bodySmall!
                //     .apply(color: dark ? EColors.light : EColors.dark),)),
                SizedBox(
                  height: EHelperFunctions.screenHeight(context) * 0.18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Divider(
                        color: dark ? EColors.light : EColors.dark,
                        thickness: 1,
                        indent: 5,
                        endIndent: 1,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const Text(
                      ETexts.supportText1,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white70),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const Flexible(
                      child: Divider(
                        color: Colors.white70,
                        thickness: 1,
                        indent: 1,
                        endIndent: 5,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
