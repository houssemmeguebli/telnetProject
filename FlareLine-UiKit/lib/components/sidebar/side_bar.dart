library flareline_uikit;

import 'dart:convert';

import 'package:flareline_uikit/components/sidebar/ConnectionPanel.dart';
import 'package:flareline_uikit/components/sidebar/side_menu.dart';
import 'package:flareline_uikit/core/theme/flareline_colors.dart';
import 'package:flutter/material.dart';


class SideBarWidget extends StatelessWidget {
  final double? width;
  final String? appName;
  final String? sideBarAsset;
  final Widget? logoWidget;
  final bool? isDark;
  final Color? darkBg;
  final Color? lightBg;
  final Widget? footerWidget;
  final double? logoFontSize;

  final ValueNotifier<String> expandedMenuName = ValueNotifier('');

  // Add a list of sensors (name and value)
  final List<Map<String, dynamic>> sensors = [
    {"name": "Temperature", "value": "25°C"},
    {"name": "Pressure", "value": "1013 hPa"},
    {"name": "Tension", "value": "60 V"},
    {"name": "Courant", "value": "5 A"},
    {"name": "Couple", "value": "10 N"},
    {"name": "Vibration", "value": "20 "},
  ];

  SideBarWidget({
    super.key,
    this.darkBg,
    this.lightBg,
    this.width,
    this.appName,
    this.sideBarAsset,
    this.logoWidget,
    this.footerWidget,
    this.logoFontSize = 30,
    this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = isDark ?? false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: (isDarkTheme ? darkBg : Colors.white),
      width: width ?? 280,
      child: Column(
        children: [
          _logoWidget(context, isDarkTheme),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              children: [
                // Menu List
                Expanded(
                  child: _sideListWidget(context, isDarkTheme),

                ),

                _buildSensorList(context, isDarkTheme),

              ],
            ),
          ),
          if (footerWidget != null) footerWidget!,
        ],
      ),
    );
  }

  // Build the logo widget
  Widget _logoWidget(BuildContext context, bool isDark) {
    return Row(
      children: [
        const SizedBox(width: 8),
        if (logoWidget != null) logoWidget!,
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            appName ?? '',
            style: TextStyle(
              color: isDark ? Colors.white : FlarelineColors.darkBlackText,
              fontSize: logoFontSize,
            ),
          ),
        ),
      ],
    );
  }

  // Build the side menu list
  Widget _sideListWidget(BuildContext context, bool isDark) {
    if (sideBarAsset == null) {
      return const SizedBox.shrink();
    }
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(sideBarAsset!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const SizedBox.shrink();
          }

          // Decode the JSON
          List listMenu = json.decode(snapshot.data.toString());
          return ListView.separated(
            padding: const EdgeInsets.only(left: 20, right: 10),
            itemBuilder: (ctx, index) {
              return itemBuilder(ctx, index, listMenu, isDark);
            },
            separatorBuilder: separatorBuilder,
            itemCount: listMenu.length,
          );
        },
      ),
    );
  }

  // Build a single menu item
  Widget itemBuilder(BuildContext context, int index, List listMenu,
      bool isDark) {
    var groupElement = listMenu.elementAt(index);
    List menuList = groupElement['menuList'];
    String? groupName = groupElement['groupName']; // 👈 Make groupName nullable

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (groupName != null && groupName.isNotEmpty) // 👈 Null check
          Text(
            groupName,
            style: TextStyle(
              fontSize: 20,
              color: isDark ? Colors.white60 : FlarelineColors.darkBlackText,
            ),
          ),
        if (groupName != null && groupName.isNotEmpty)
          const SizedBox(height: 10),
        Column(
          children: menuList.map((e) =>
              SideMenuWidget(
                e: e,
                isDark: isDark,
                expandedMenuName: expandedMenuName,
              )).toList(),
        ),
        const SizedBox(height: 10),
        if (index < listMenu.length - 1) const Divider(),
        const SizedBox(height: 10),
      ],
    );
  }

  // Build the separator between menu items
  Widget separatorBuilder(BuildContext context, int index) {
    return const Divider(
      height: 10,
      color: Colors.transparent,
    );
  }


  // Build the sensor list with a more professional look
  Widget _buildSensorList(BuildContext context, bool isDark) {
    return Container(

      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          ...sensors.map((sensor) => _buildSensorItem(sensor, isDark)).toList(),
        ],

      ),
    );
  }

  // Build a single sensor item with modern styling
  Widget _buildSensorItem(Map<String, dynamic> sensor, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sensor["name"],
              style: TextStyle(
                fontSize: 14,

                color: isDark ? Colors.white70 : FlarelineColors.darkBlackText,
              ),
            ),
            Text(
              sensor["value"],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : FlarelineColors.darkBlackText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}