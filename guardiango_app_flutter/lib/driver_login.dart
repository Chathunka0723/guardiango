import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/driver_home.dart';
import 'package:guardiango_app_flutter/driver_signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:guardiango_app_flutter/forgot_password.dart';
import 'package:guardiango_app_flutter/driver_registration_main.dart';
import 'package:guardiango_app_flutter/registration_submitted_screen.dart';




class DriverLogin extends StatefulWidget {
  const DriverLogin({super.key});

  @override
  State<DriverLogin> createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
  final SupabaseClient supabase = Supabase.instance.client;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isObscure = true;
  bool _loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

Future<void> _login() async {
  final supabase = Supabase.instance.client;

  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please enter both email and password"),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
  setState(() => _loading = true);

  try {
    final res = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = res.user;

    if (user == null) {
      throw Exception("Login failed");
    }

    final supabase = Supabase.instance.client;

    final profile = await supabase
        .from('profile')
        .select()
        .eq('profile_id', user.id)
        .single();


      
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DriverhomeScreen(
              busId: profile['vehicle_code'] ?? "",
            ),
          ),
        );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login failed. Please check your credentials."),
        backgroundColor: Colors.red,
      ),
    );

  }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF3C7),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // 1. Logo & App Name
              Image.asset('assets/bus_logo.png', height: 60),
              const Text(
                'GuardianGo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome Back !',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 20),

              // 2. Main Login Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Driver Role',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),


                    // Email Field
                    _inputLabel('Email or Phone'),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Password Field
                    _inputLabel('Password'),
                    TextField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        filled: true,
                        fillColor: Colors.grey[200],
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _isObscure = !_isObscure),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _login,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFACC15), // Yellow color
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.black, 
                            fontSize: 18, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Forgot Password Link
                    // Forgot Password Link
                    Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPasswordScreen()),
                        );*/
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {},
                          child: const Text('Sign Up', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              // Footer Text
              const Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy. Your data is protected and never shared with third parties.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _socialButton(String iconPath, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset(iconPath, height: 24),
      label: Text(label, style: const TextStyle(color: Colors.black)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _inputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}