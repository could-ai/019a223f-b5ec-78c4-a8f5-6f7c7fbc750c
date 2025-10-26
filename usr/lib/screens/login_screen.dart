import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_constants.dart';
import '../widgets/otp_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;
  bool _isLoading = false;
  String? _error;
  
  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (_phoneController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool success = await authProvider.sendOtp(_phoneController.text);
    
    setState(() {
      _isLoading = false;
      if (success) {
        _otpSent = true;
      } else {
        _error = authProvider.error;
      }
    });
  }
  
  Future<void> _verifyOtp(String otp) async {
    if (otp.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool success = await authProvider.verifyOtp(_phoneController.text, otp);
    
    setState(() {
      _isLoading = false;
    });
    
    if (success) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() {
        _error = authProvider.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome to ${AppConstants.appName}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Login with your phone number',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixText: '+880 ',
                  border: OutlineInputBorder(),
                ),
                enabled: !_otpSent,
              ),
              const SizedBox(height: 20),
              if (_otpSent) ...[
                OtpInputField(
                  controller: _otpController,
                  onCompleted: _verifyOtp,
                ),
                const SizedBox(height: 20),
              ],
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : (_otpSent ? () => _verifyOtp(_otpController.text) : _sendOtp),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(_otpSent ? 'Verify OTP' : 'Send OTP'),
              ),
              if (_otpSent) ...[
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _otpSent = false;
                      _otpController.clear();
                    });
                  },
                  child: const Text('Change Phone Number'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}