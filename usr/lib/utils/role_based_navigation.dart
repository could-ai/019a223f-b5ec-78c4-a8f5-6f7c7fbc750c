import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RoleBasedNavigation {
  static Widget getDashboard(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    if (authProvider.isSR) {
      return const DashboardScreen();
    } else if (authProvider.isDealer) {
      return const DealerDashboardScreen();
    } else {
      // Default to SR dashboard or show error
      return const DashboardScreen();
    }
  }
  
  static Widget getCreateOrderScreen(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    if (authProvider.isSR) {
      return const CreateOrderScreen();
    } else if (authProvider.isDealer) {
      return const DealerCreateOrderScreen();
    } else {
      return const DealerCreateOrderScreen(); // Default
    }
  }
}
