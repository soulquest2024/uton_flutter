

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uton_flutter/common/app_constant.dart';
import 'package:uton_flutter/common/common_widgets/app_text.dart';
import 'package:uton_flutter/common/common_widgets/common_widgets.dart';
import 'package:uton_flutter/dependency_injection/service_locator.dart';
import 'package:uton_flutter/home/programs/home_programs.dart';
import 'package:uton_flutter/providers/home_provider.dart';
import 'package:uton_flutter/search/search_screen.dart';
import 'package:uton_flutter/settings/settings_screen.dart';
import 'package:uton_flutter/shrine/shrine_screen.dart';

import 'offers/home_offers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Widget _currentWidget;

  List<String> headers = ['Programok', 'Ajánlatok'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _currentWidget = locator<HomePrograms>();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      debugPrint("Changing tab: ${_tabController.index}");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
          children:
          [
            imageAsset("background.png", fit: BoxFit.fitWidth, width: getScreenSize(context).width, height: getScreenSize(context).height),
            _mainContent()
          ],
        )
    );
  }

  Widget _mainContent() {
    return SafeArea(
      bottom: true,
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(
                child: Container(
                  color: _tabController.index == 0 ? Resources.color.primaryColor : Resources.color.thirdColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 2.0),
                        imageAsset("tabHome.png", fit: BoxFit.fill, width: 24, height: 24, color: _tabController.index == 0 ? Colors.black : Colors.black26),
                        AppText('home_title'.tr(), textStyle: Resources.textStyle.koHoSmallText(color: _tabController.index == 0 ? Resources.color.textColor : Colors.black26, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: _tabController.index == 1 ? Resources.color.primaryColor : Resources.color.thirdColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 2.0),
                        imageAsset("tabSearch.png", fit: BoxFit.fill, width: 24, height: 24, color: _tabController.index == 1 ? Colors.black : Colors.black26),
                        AppText(tr('tab_search'), textStyle: Resources.textStyle.koHoSmallText(color: _tabController.index == 1 ? Resources.color.textColor : Colors.black26, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: _tabController.index == 2 ? Resources.color.primaryColor : Resources.color.thirdColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 2.0),
                        imageAsset("tabShrine.png", fit: BoxFit.fill, width: 24, height: 24, color: _tabController.index == 2 ? Colors.black : Colors.black26),
                        AppText('tab_shrine'.tr(), textStyle: Resources.textStyle.koHoSmallText(color: _tabController.index == 2 ? Resources.color.textColor : Colors.black26, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: _tabController.index == 3 ? Resources.color.primaryColor : Resources.color.thirdColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 2.0),
                        imageAsset("tabExperiences.png", fit: BoxFit.fill, width: 24, height: 24, color: _tabController.index == 3 ? Colors.black : Colors.black26),
                        AppText(tr('tab_experiences'), textStyle: Resources.textStyle.koHoSmallText(color: _tabController.index == 3 ? Resources.color.textColor : Colors.black26, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  color: _tabController.index == 4 ? Resources.color.primaryColor : Resources.color.thirdColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 2.0),
                        imageAsset("tabSettings.png", fit: BoxFit.fill, width: 24, height: 24, color: _tabController.index == 4 ? Colors.black : Colors.black26),
                        AppText(tr('tab_settings'), textStyle: Resources.textStyle.koHoSmallText(color: _tabController.index == 4 ? Resources.color.textColor : Colors.black26, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              _mainPage(),
              SearchScreen(),
              ShrineScreen(),
              Center(child: Text('Experiences Tab')),
              locator<SettingsScreen>(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainPage() {
    return Column(
      children: [
        Container(
          color: Resources.color.thirdColor,
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: headers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    switch (index) {
                      case 0:
                        _currentWidget = locator<HomePrograms>();
                        break;
                      case 1:
                        _currentWidget = locator<HomeOffers>();
                        break;
                    }
                  });
                },
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Global.mainPadding),
                      child: AppText(headers[index])
                  ),
                ),
              );
            },
          ),
        ),
        _currentWidget,
      ],
    );
  }
}

