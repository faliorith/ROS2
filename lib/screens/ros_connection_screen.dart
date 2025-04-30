import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../services/theme_service.dart';

class RosConnectionScreen extends StatefulWidget {
  const RosConnectionScreen({super.key});

  @override
  State<RosConnectionScreen> createState() => _RosConnectionScreenState();
}

class _RosConnectionScreenState extends State<RosConnectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hostController = TextEditingController();
  final _portController = TextEditingController();
  bool _isConnected = false;
  bool _isLoading = false;
  String? _errorMessage;
  static const String _hostKey = 'ros_host';
  static const String _portKey = 'ros_port';

  @override
  void initState() {
    super.initState();
    _loadSavedSettings();
  }

  Future<void> _loadSavedSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedHost = prefs.getString(_hostKey) ?? 'localhost';
      final savedPort = prefs.getString(_portKey) ?? '9090';
      
      setState(() {
        _hostController.text = savedHost;
        _portController.text = savedPort;
      });
    } catch (e) {
      debugPrint('Ошибка при загрузке настроек: $e');
    }
  }

  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_hostKey, _hostController.text);
      await prefs.setString(_portKey, _portController.text);
    } catch (e) {
      debugPrint('Ошибка при сохранении настроек: $e');
    }
  }

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeService = Provider.of<ThemeService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.rosStatus),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            _isConnected ? Icons.check_circle : Icons.error,
                            color: _isConnected ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isConnected ? l10n.connected : l10n.disconnected,
                            style: TextStyle(
                              color: _isConnected ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _hostController,
                decoration: InputDecoration(
                  labelText: l10n.host,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.computer),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterHost.toString();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _portController,
                decoration: InputDecoration(
                  labelText: l10n.port,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterPort.toString();
                  }
                  final port = int.tryParse(value);
                  if (port == null || port < 1 || port > 65535) {
                    return l10n.invalidPort.toString();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _isConnected ? _disconnect : _connect,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: _isConnected ? Colors.red : Theme.of(context).primaryColor,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _isConnected ? l10n.disconnect : l10n.connect,
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _connect() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        await _saveSettings();
        // TODO: Implement ROS connection logic
        await Future.delayed(const Duration(seconds: 2)); // Имитация подключения
        setState(() {
          _isConnected = true;
          _isLoading = false;
        });
      } catch (e) {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          setState(() {
            _isLoading = false;
            _errorMessage = l10n.connectionError;
          });
        }
      }
    }
  }

  Future<void> _disconnect() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // TODO: Implement ROS disconnection logic
      await Future.delayed(const Duration(seconds: 1)); // Имитация отключения
      setState(() {
        _isConnected = false;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        setState(() {
          _isLoading = false;
          _errorMessage = l10n.disconnectionError;
        });
      }
    }
  }
} 