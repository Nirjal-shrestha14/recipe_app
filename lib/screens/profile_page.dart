import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final int savedCount;
  final VoidCallback onLogout;
  ProfilePage({required this.savedCount, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: theme.textTheme.titleLarge),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
      ),
      body: Center(child: Text('Profile Page', style: theme.textTheme.bodyLarge)),
    );
  }
}