import 'package:athlete_aware/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _educatorCodeController = TextEditingController();
  String _selectedRole = 'Educator';
  String _selectedSport = 'Cricket';
  String _selectedLevel = 'Beginner';
  bool _obscurePassword = true;
    bool _isGoogleLoading = false; // Loading state for Google Sign-In

  bool _isLoading = false;

  final List<String> sports = [
    'Cricket',
    'Football',
    'Tennis',
    'Badminton',
    'Basketball',
    'Swimming',
    'Hockey',
    'Golf',
    'Baseball',
    'Cycling',
  ];

  final List<String> levels = ['Beginner', 'Intermediate', 'Professional'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _educatorCodeController.dispose();
    super.dispose();
  }

Future<void> _signUpUser() async {
  if (_selectedRole == 'Educator' &&
      _educatorCodeController.text.trim() != 'educator') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid Educator Code.'),
      ),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    // Create user with email and password
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // Send email verification
    await userCredential.user!.sendEmailVerification();

    // Save user details in Firestore
    String uid = userCredential.user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'role': _selectedRole,
      'sport': _selectedSport,
      'level': _selectedLevel,
      'profileImage': '', // Initially empty
      'status': 'active', // Set as inactive until email is verified
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Sign-up successful! Please check your email for verification.'),
      ),
    );

    // Navigate back to the Sign-In screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message ?? 'Sign-up failed. Please try again.')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  
  Future<void> signInWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      // Sign out any previous Google session
      await GoogleSignIn().signOut();

      // Initiate Google sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // If the user cancels the Google sign-in flow, return early
        setState(() {
          _isGoogleLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // Use the Google credential to authenticate with Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with Firebase using the Google credentials
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if user already exists in Firestore
      User? user = userCredential.user;
      if (user != null) {
        await _initializeFirestoreUser(user);
      }

      // Navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(), // Redirect to the main app after sign-up
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account Created Successfully! You can now sign in.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: ${e.message}'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred, please try again later'),
        ),
      );
    } finally {
      setState(() {
        _isGoogleLoading = false;
      });
    }
  }

    Future<void> _initializeFirestoreUser(User user) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    // If the user doesn't exist in Firestore, create a new document
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
         'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'role': _selectedRole,
        'sport': _selectedSport,
        'level': _selectedLevel,
        'profileImage': '', // Initially empty
        'status': 'active',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 107, 158, 197), // Very light bluish background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate to the previous screen
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // Logo
                    Image.asset(
                      'assets/logo2.png', // Add your logo path here
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  'Getting Started!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  'Create an account to continue your allCourses',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                const SizedBox(height: 30),

                // Name Field
          
// Name Field
TextFormField(
  controller: _nameController,
  style: const TextStyle(
    color: Colors.black, // Black input text color
    fontWeight: FontWeight.bold, // Bold input text
  ),
  decoration: InputDecoration(
    labelText: 'Name',
    hintText: 'Roman Kamush',
    hintStyle: const TextStyle(
      color: Color.fromARGB(255, 200, 200, 200), // Light gray hint text
    ),
    labelStyle: const TextStyle(
      color: Color.fromARGB(172, 111, 34, 243), // Purple label text
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    filled: true,
    fillColor: const Color(0xFFEAF6FF), // Light blue background
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Rounded border
      borderSide: BorderSide.none, // No default border
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 110, 34, 243), // Purple border on focus
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 15, // Adjust vertical padding
      horizontal: 20, // Adjust horizontal padding
    ),
  ),
),
const SizedBox(height: 20),

// Email Field
TextFormField(
  controller: _emailController,
  style: const TextStyle(
    color: Colors.black, // Black input text color
    fontWeight: FontWeight.bold,
  ),
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    hintStyle: const TextStyle(
      color: Color.fromARGB(255, 200, 200, 200), // Light gray hint text
    ),
    labelStyle: const TextStyle(
      color: Color.fromARGB(172, 111, 34, 243), // Purple label text
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    filled: true,
    fillColor: const Color(0xFFEAF6FF), // Light blue background
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Rounded border
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 110, 34, 243),
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 15,
      horizontal: 20,
    ),
  ),
),
const SizedBox(height: 20),

// Password Field
TextFormField(
  controller: _passwordController,
  obscureText: _obscurePassword,
  style: const TextStyle(
    color: Colors.black, // Black input text color
    fontWeight: FontWeight.bold,
  ),
  decoration: InputDecoration(
    labelText: 'Password',
    hintText: 'Enter your password',
    hintStyle: const TextStyle(
      color: Color.fromARGB(255, 200, 200, 200), // Light gray hint text
    ),
    labelStyle: const TextStyle(
      color: Color.fromARGB(172, 111, 34, 243), // Purple label text
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    suffixIcon: IconButton(
      icon: Icon(
        _obscurePassword ? Icons.visibility_off : Icons.visibility,
        color: const Color.fromARGB(172, 111, 34, 243), // Purple icon color
      ),
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
    ),
    filled: true,
    fillColor: const Color(0xFFEAF6FF), // Light blue background
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 110, 34, 243),
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 15,
      horizontal: 20,
    ),
  ),
),
const SizedBox(height: 20),


Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Role Dropdown
    DropdownButtonFormField<String>(
      value: _selectedRole.isNotEmpty ? _selectedRole : null,
      items: ['Educator', 'Athlete']
          .map((role) => DropdownMenuItem(
                value: role,
                child: Text(
                  role,
                  style: const TextStyle(
                    color: Colors.black, // Black text for dropdown options
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedRole = value!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Role', // Floating label text
        labelStyle: const TextStyle(
          color: Color.fromARGB(172, 111, 34, 243), // Purple label color
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: const Color(0xFFEAF6FF), // Light blue background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 110, 34, 243), // Purple border on focus
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18, // Increased height for the box
          horizontal: 20, // Padding inside the box
        ),
        suffixIcon: const Icon(
          Icons.arrow_drop_down, // Dropdown arrow icon
          color: Colors.black,
        ),
      ),
      dropdownColor: Colors.white, // Dropdown menu background
    ),

    // Educator Code Field (Only for Educators)
    if (_selectedRole == 'Educator') ...[
          const SizedBox(height: 20),

      TextFormField(
        controller: _educatorCodeController,
        style: const TextStyle(
          color: Colors.black, // Text color
        ),
        decoration: InputDecoration(
          labelText: 'Educator Code', // Floating label text
          labelStyle: const TextStyle(
            color: Color.fromARGB(172, 111, 34, 243), // Purple label color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: const Color(0xFFEAF6FF), // Light blue background
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 110, 34, 243), // Purple border on focus
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15, // Increased height for the box
            horizontal: 20, // Padding inside the box
          ),
        ),
      ),
      const SizedBox(height: 20), // Spacing below Educator Code field
    ] else ...[
      const SizedBox(height: 20), // Maintain spacing when Athlete is selected
    ],
  ],
),


// Sport Dropdown
DropdownButtonFormField<String>(
  value: _selectedSport.isNotEmpty ? _selectedSport : null,
  hint: const Text(
    'Sport', // Placeholder text inside the field
    style: TextStyle(
      color: Color.fromARGB(172, 111, 34, 243), // Purple hint text
      fontSize: 18, // Increased font size for better visibility
      fontWeight: FontWeight.bold,
    ),
  ),
  items: sports
      .map((sport) => DropdownMenuItem(
            value: sport,
            child: Text(
              sport,
              style: const TextStyle(
                color: Colors.black, // Black dropdown item text
                fontWeight: FontWeight.bold,
              ),
            ),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      _selectedSport = value!;
    });
  },
  decoration: InputDecoration(
    labelText: 'Sport', // Floating label text
    labelStyle: const TextStyle(
      color: Color.fromARGB(172, 111, 34, 243), // Purple label text
      fontSize: 18, // Increased font size
      fontWeight: FontWeight.bold,
    ),
    filled: true,
    fillColor: const Color(0xFFEAF6FF), // Light blue background
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Rounded border
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 110, 34, 243), // Purple border on focus
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 18, // Increased height for the box
      horizontal: 20, // Padding inside the box
    ),
    suffixIcon: const Icon(
      Icons.arrow_drop_down, // Dropdown arrow icon
      color: Colors.black,
    ),
  ),
  dropdownColor: Colors.white, // White dropdown menu background
),
const SizedBox(height: 20),

// Level Dropdown
DropdownButtonFormField<String>(
  value: _selectedLevel.isNotEmpty ? _selectedLevel : null,
  hint: const Text(
    'Level', // Placeholder text inside the field
    style: TextStyle(
      color: Color.fromARGB(255, 110, 34, 243), // Purple hint text
      fontSize: 18, // Increased font size for better visibility
      fontWeight: FontWeight.bold,
    ),
  ),
  items: levels
      .map((level) => DropdownMenuItem(
            value: level,
            child: Text(
              level,
              style: const TextStyle(
                color: Colors.black, // Black dropdown item text
                fontWeight: FontWeight.bold,
              ),
            ),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      _selectedLevel = value!;
    });
  },
  decoration: InputDecoration(
    labelText: 'Level', // Floating label text
    labelStyle: const TextStyle(
      color: Color.fromARGB(172, 111, 34, 243), // Purple label text
      fontSize: 18, // Increased font size
      fontWeight: FontWeight.bold,
    ),
    filled: true,
    fillColor: const Color(0xFFEAF6FF), // Light blue background
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), // Rounded border
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 110, 34, 243), // Purple border on focus
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 18, // Increased height for the box
      horizontal: 20, // Padding inside the box
    ),
    suffixIcon: const Icon(
      Icons.arrow_drop_down, // Dropdown arrow icon
      color: Colors.black,
    ),
  ),
  dropdownColor: Colors.white, // White dropdown menu background
),
const SizedBox(height: 20),





                // Sign-Up Button

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signUpUser,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor:
                          const Color(0xFF0A3D91), // Dark blue color
                      shadowColor: Colors.black.withOpacity(0.2), // Soft shadow
                      elevation: 5, // Raised button effect
                    ),
                    child: _isLoading
                        ? const SpinKitFadingCircle(color: Colors.white)
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize:
                                      20, // Larger font size for better visibility
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // White text
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward, // Add an arrow icon
                                color: Colors.white,
                                size: 22,
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 15),

                // Social Login Options
                // const Text(
                //   'Or Continue With',
                //   style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 16),
                // ),
                // const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/google.svg', // Path to your Google SVG
                        height: 40,
                        width: 40,
                      ),
                      iconSize: 40,
                      onPressed: () async{
                        // Handle Google Sign-In
                        await signInWithGoogle();
                      },
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/facebook-logo.svg', // Path to your Facebook SVG
                        height: 40,
                        width: 40,
                      ),
                      iconSize: 40,
                      onPressed: () {
                        // Handle Facebook Sign-In
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Sign-In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account? ",
                      style: TextStyle(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (e) => const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 19, 107, 223),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

