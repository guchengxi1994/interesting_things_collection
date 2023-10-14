import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/catalog_screen.dart';
import 'package:interesting_things_collection/layout/expand_collapse_notifier.dart';
import 'package:interesting_things_collection/notifier/color_notifier.dart';
import 'package:interesting_things_collection/settings/settings_screen.dart';
import 'package:interesting_things_collection/style/app_style.dart';
import 'package:window_manager/window_manager.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return LayoutState();
  }
}

class LayoutState extends ConsumerState<Layout> with TickerProviderStateMixin {
  late final notifier =
      ExpandCollapseNotifier(minWidth: minWidth, maxWidth: maxWidth);
  final PageController controller = PageController();
  int selected = 0;

  static const double minWidth = 70;
  static const double maxWidth = 200;

  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _animation;

  bool isExpanded = false;

  _toggleSidemenu() {
    if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    notifier.addListener(() => mounted ? setState(() {}) : null);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation =
        _controller.drive(Tween<double>(begin: minWidth, end: maxWidth));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(AppStyle.appbarHeight),
        child: WindowCaption(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                color: Colors.transparent,
                child: NavigationRail(
                  onDestinationSelected: (value) {
                    if (value != selected) {
                      controller.jumpToPage(value);
                      setState(() {
                        selected = value;
                      });
                    }
                  },
                  backgroundColor: Colors.transparent,
                  destinations: [
                    NavigationRailDestination(
                        icon: const Icon(
                          Icons.book,
                        ),
                        label: const Text("Catalogs"),
                        selectedIcon: Icon(
                          Icons.book,
                          color: AppStyle.catalogCardBorderColors[
                              ref.watch(colorNotifier).currentColor],
                        )),
                    NavigationRailDestination(
                        icon: const Icon(
                          Icons.transform,
                        ),
                        label: const Text("Data Transfer"),
                        selectedIcon: Icon(
                          Icons.transform,
                          color: AppStyle.catalogCardBorderColors[
                              ref.watch(colorNotifier).currentColor],
                        )),
                    NavigationRailDestination(
                        icon: const Icon(
                          Icons.settings,
                        ),
                        label: const Text("Settings"),
                        selectedIcon: Icon(
                          Icons.settings,
                          color: AppStyle.catalogCardBorderColors[
                              ref.watch(colorNotifier).currentColor],
                        ))
                  ],
                  selectedIndex: selected,
                  extended: notifier.isExpanded,
                  minWidth: minWidth,
                  minExtendedWidth: maxWidth,
                ),
              ),
              Expanded(
                  child: SizedBox.expand(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: const [
                    CatalogScreen(),
                    SizedBox(),
                    SettingsScreen(),
                  ],
                ),
              ))
            ],
          ),
          Positioned(
              left: notifier.currentWidth - 10,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeft,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final b = notifier.changeSidemenuWidth(details);
                    if (isExpanded != b) {
                      setState(() {
                        isExpanded = b;
                      });
                      _toggleSidemenu();
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 20,
                    height: MediaQuery.of(context).size.height,
                    // child: const SizedBox.expand(),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
