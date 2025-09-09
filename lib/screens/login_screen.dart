import 'package:flutter/material.dart';

/// Tela de login simples para PluviApp.
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _matriculaController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _loading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simula login
    setState(() => _loading = false);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF233A7A),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SEJA BEM VINDO,\nALUNO(A)!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7FFF7F),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              // Imagen ilustrativa (puedes cambiar por AssetImage si tienes el asset)
              Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF3B5998),
                ),
                child: Icon(Icons.water_drop, size: 100, color: Color(0xFF7FFF7F)),
              ),
              const SizedBox(height: 24),
              const Text(
                'VAMOS COMEÇAR\nCOM O SEU LOGIN?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7FFF7F),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _matriculaController,
                      decoration: InputDecoration(
                        labelText: 'MATRÍCULA:',
                        labelStyle: const TextStyle(color: Color(0xFF7FFF7F)),
                        filled: true,
                        fillColor: const Color(0xFF5A5ACF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (v) => v == null || v.isEmpty ? 'Informe a matrícula' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'SENHA:',
                        labelStyle: const TextStyle(color: Color(0xFF7FFF7F)),
                        filled: true,
                        fillColor: const Color(0xFF5A5ACF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (v) => v == null || v.isEmpty ? 'Informe a senha' : null,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7FFF7F),
                          foregroundColor: const Color(0xFF233A7A),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(color: Color(0xFF233A7A))
                            : const Text('ENTRAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
