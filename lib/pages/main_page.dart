part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> pages = const [HomePage(), PlanningPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
              label: 'Beranda'),
          BottomNavigationBarItem(
              icon:
                  Icon(currentIndex == 1 ? Icons.timer : Icons.timer_outlined),
              label: 'Rencana'),
          BottomNavigationBarItem(
              icon:
                  Icon(currentIndex == 2 ? Icons.person : Icons.person_outline),
              label: 'profile'),
        ],
      ),
      floatingActionButton: const HoldActionFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
