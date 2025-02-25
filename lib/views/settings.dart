import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  String _selectedLanguage = 'English';
  bool _showDueDates = true;
  bool _autoSave = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _darkMode = prefs.getBool('dark_mode') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'English';
      _showDueDates = prefs.getBool('show_due_dates') ?? true;
      _autoSave = prefs.getBool('auto_save') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', _notificationsEnabled);
    await prefs.setBool('dark_mode', _darkMode);
    await prefs.setString('language', _selectedLanguage);
    await prefs.setBool('show_due_dates', _showDueDates);
    await prefs.setBool('auto_save', _autoSave);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('General'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            secondary: const Icon(LucideIcons.moon),
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
                _saveSettings();
              });
              // Implement theme switching logic here
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_selectedLanguage),
            leading: const Icon(LucideIcons.languages),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () => _showLanguageDialog(),
          ),
          const Divider(),
          _buildSectionHeader('Notifications'),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            subtitle: const Text('Receive reminders and updates'),
            secondary: const Icon(LucideIcons.bell),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
                _saveSettings();
              });
            },
          ),
          const Divider(),
          _buildSectionHeader('Display'),
          SwitchListTile(
            title: const Text('Show Due Dates'),
            subtitle: const Text('Display due dates in assignment list'),
            secondary: const Icon(LucideIcons.calendar),
            value: _showDueDates,
            onChanged: (bool value) {
              setState(() {
                _showDueDates = value;
                _saveSettings();
              });
            },
          ),
          const Divider(),
          _buildSectionHeader('Data & Storage'),
          SwitchListTile(
            title: const Text('Auto Save'),
            subtitle: const Text('Automatically save changes'),
            secondary: const Icon(LucideIcons.save),
            value: _autoSave,
            onChanged: (bool value) {
              setState(() {
                _autoSave = value;
                _saveSettings();
              });
            },
          ),
          ListTile(
            title: const Text('Clear Cache'),
            subtitle: const Text('Delete temporary files'),
            leading: const Icon(LucideIcons.trash2),
            onTap: () => _showClearCacheDialog(),
          ),
          const Divider(),
          _buildSectionHeader('Account'),
          ListTile(
            title: const Text('Profile Settings'),
            leading: const Icon(LucideIcons.user),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () {
              // Navigate to profile settings
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(LucideIcons.shield),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          ListTile(
            title: const Text('About'),
            leading: const Icon(LucideIcons.info),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () {
              // Navigate to about page
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement logout functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Log Out'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Future<void> _showLanguageDialog() async {
    final languages = ['English', 'Spanish', 'French', 'German', 'Chinese'];

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(languages[index]),
                  trailing: _selectedLanguage == languages[index]
                      ? Icon(LucideIcons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = languages[index];
                      _saveSettings();
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _showClearCacheDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cache'),
          content: const Text(
              'Are you sure you want to clear the cache? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Clear'),
              onPressed: () {
                // Implement cache clearing logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache cleared successfully')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
