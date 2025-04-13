import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsy_app/core/di/di.dart';
import 'package:newsy_app/features/news/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late PageController pageController;
  final dashboardBloc = getIt<DashboardBloc>();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    dashboardBloc.add(InitialDashboardEvent());
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) => dashboardBloc.add(PageChangedEvent(index)),
                children: dashboardBloc.navWidgets,
              ),
            ),
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                return Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFB20909), Colors.black, Color(0xFFB20909)],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: dashboardBloc
                        .navItems
                        .asMap()
                        .entries
                        .map(
                          (item) => GestureDetector(
                            onTap: () => dashboardBloc.add(NavigationToggleEvent(item.key, pageController)),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Image.asset(
                                state.page == item.key ? item.value.selectedIcon : item.value.icon,
                                height: 30,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            /*BlocBuilder<DashboardBloc, DashboardState>(
              buildWhen: (previous, current) => previous.page != current.page,
              builder: (context, state) {
                final navItems = context.read<DashboardBloc>().navItems;
                return Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFB20909), Colors.black, Color(0xFFB20909)],
                      ),
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: navItems.asMap().entries.map((item) {
                      return GestureDetector(
                        onTap: () => context.read<DashboardBloc>().add(
                            NavigationToggleEvent(item.key, pageController)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image.asset(
                            state.page == item.key
                                ? item.value.selectedIcon
                                : item.value.icon,
                            height: 30,
                            // color: state.page == item.key ? Colors.white : null,
                            // colorBlendMode: BlendMode.srcIn,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
