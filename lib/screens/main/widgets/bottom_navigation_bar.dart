part of '../main_screen.dart';

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainBloc, MainState, int>(
      selector: (state) => state.selectedIndex,
      builder: (context, selectedIndex) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          selectedItemColor:  Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 1,
          ),
          unselectedFontSize: 1,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: '',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (index) async {
            if (selectedIndex == index) return;
            if (!context.mounted) {
              return;
            }
            context
                .read<MainBloc>()
                .add(UpdateSelectedIndex(selectedIndex: index));
          },
        );
      },
    );
  }
}
