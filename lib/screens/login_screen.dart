import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: auth.user != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Halo, ${auth.user!.displayName ?? 'User'}",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                    child: const Text("Masuk ke Movie App"),
                  ),
                  TextButton(
                    onPressed: auth.signOut,
                    child: const Text("Logout"),
                  ),
                ],
              )
            : auth.isLoading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (auth.errorMessage != null)
                        Text(
                          auth.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: auth.signInWithGoogle,
                        child: const Text("Login dengan Google"),
                      ),
                    ],
                  ),
      ),
    );
  }
}
