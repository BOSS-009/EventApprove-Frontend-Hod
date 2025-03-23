import 'package:flutter/material.dart';
import 'package:hod_app/login.dart';
import 'package:hod_app/screens/accepted.dart';
import 'package:hod_app/screens/rejected.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import all the necessary pages
import 'screens/ViewOnlyPages/IAmarksView.dart';
import 'screens/ViewOnlyPages/ConferencesView.dart';
import 'screens/ViewOnlyPages/JournalsView.dart';
import 'screens/ViewOnlyPages/BookChapterView.dart';
import 'screens/ViewOnlyPages/PatentsView.dart';
import 'screens/ViewOnlyPages/EventsView.dart';
import 'screens/ViewOnlyPages/WorkshopsView.dart';
import 'screens/ViewOnlyPages/FDView.dart';
import 'screens/ViewOnlyPages/SeminarsView.dart';
import 'screens/ViewOnlyPages/ClubActivitiesView.dart'; // Import the ClubActivitiesView
import 'screens/ViewOnlyPages/IndustrialVisitsView.dart';
import 'screens/ViewOnlyPages/FacultyAchievementsView.dart';
import 'screens/ViewOnlyPages/StudentAchievementsView.dart';
import 'screens/ViewOnlyPages/ProfessionalSocietiesView.dart';
import 'screens/ViewOnlyPages/UnknownEventPage.dart';

void main() {
  runApp(const HODDashboardApp());
}

class HODDashboardApp extends StatelessWidget {
  const HODDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSU-HOD Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xfff8f9fd),
      ),
      home: const SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffcc9f1f),
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(seconds: 2),
          child: Text(
            'Welcome to DSU-HOD Dashboard!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// HomePage for HOD
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.username});
  final String? username;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Widget _buildMainContent() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboardGrid();
      case 1:
        return const ReportsView();
      case 2:
        return const Accepted(state: true);
      case 3:
        return const Rejected(state: false);
      case 4:
        return const SettingsView();
      default:
        return _buildDashboardGrid();
    }
  }

  Widget _buildDashboardGrid() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'HOD Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: [
                buildCategoryCard("IA Marks", Icons.school),
                buildCategoryCard("Conferences", Icons.business),
                buildCategoryCard("Journals", Icons.book),
                buildCategoryCard("Book- chapter/Published", Icons.menu_book),
                buildCategoryCard("Patents", Icons.lightbulb),
                buildCategoryCard("Workshops", Icons.work),
                buildCategoryCard("FDP", Icons.people),
                buildCategoryCard("Seminars/Webinars", Icons.web),
                buildCategoryCard("Club Activities", Icons.group),
                buildCategoryCard("Industrial Visits", Icons.factory),
                buildCategoryCard("Faculty Major Achievements", Icons.star),
                buildCategoryCard(
                    "Student Major Achievements", Icons.emoji_events),
                buildCategoryCard(
                    "Professional Societies activities", Icons.account_balance),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          HODSidebar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() => _currentIndex = index);
            },
            onLogout: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('hod');
              await prefs.setBool('isLogged', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            username: widget.username,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: _buildMainContent(),
            ),
          ),
        ],
      ),
    );
  }

  // Category card builder
  Widget buildCategoryCard(String label, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: const Color(0xffcc9f1f),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => getPageForEvent(label)),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get the page based on the event type
  Widget getPageForEvent(String eventType) {
    switch (eventType) {
      case "IA Marks":
        return const IAmarksView();
      case "Conferences":
        return const ConferencesView();
      case "Journals":
        return const JournalsView();
      case "Book- chapter/Published":
        return const BookChapterView();
      case "Patents":
        return const PatentsView();
      case "Events":
        return const EventsView();
      case "Workshops":
        return const WorkshopsView();
      case "FDP":
        return const FDView();
      case "Seminars/Webinars":
        return const SeminarsView();
      case "Club Activities":
        return const ClubActivitiesView(); // Added Club Activities Page
      case "Industrial Visits":
        return const IndustrialVisitsView();
      case "Faculty Major Achievements":
        return const FacultyAchievementsView();
      case "Student Major Achievements":
        return const StudentAchievementsView();
      case "Professional Societies activities":
        return const ProfessionalSocietiesView();
      default:
        return const UnknownEventPage();
    }
  }
}

class HODSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onLogout;
  final String? username;

  const HODSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onLogout,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: const Color(0xffcc9f1f),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          const Text(
            'DSU-HOD Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          if (username != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Welcome, $username',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _SidebarItem(
                  icon: Icons.dashboard,
                  label: "Dashboard",
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemSelected(0),
                ),
                // _SidebarItem(
                //   icon: Icons.list_alt,
                //   label: "View Reports",
                //   isSelected: selectedIndex == 1,
                //   onTap: () => onItemSelected(1),
                // ),
                _SidebarItem(
                  icon: Icons.check_circle,
                  label: "Accepted",
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemSelected(2),
                ),
                _SidebarItem(
                  icon: Icons.cancel,
                  label: "Rejected",
                  isSelected: selectedIndex == 3,
                  onTap: () => onItemSelected(3),
                ),
                _SidebarItem(
                  icon: Icons.settings,
                  label: "Settings",
                  isSelected: selectedIndex == 4,
                  onTap: () => onItemSelected(4),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: _SidebarItem(
              icon: Icons.logout_outlined,
              label: "Logout",
              isSelected: false,
              onTap: onLogout,
              textColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.textColor,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected ? Colors.white : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: textColor ?? Colors.white.withOpacity(0.9),
                size: 20,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: textColor ?? Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reports',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xffcc9f1f),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Text(
                'Reports View Content',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xffcc9f1f),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Text(
                'Settings View Content',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
