import 'package:flutter/material.dart';

const List<NavigationRailDestination> railDestinations = [
  NavigationRailDestination(
    padding: EdgeInsets.only(top: 20, bottom: 5),
    label: Text('Home'),
    icon: Icon(Icons.home),
  ),
  NavigationRailDestination(
    padding: EdgeInsets.only(top: 5, bottom: 5),
    label: Text('Accounts'),
    icon: Icon(Icons.account_circle),
  ),
  NavigationRailDestination(
    padding: EdgeInsets.only(top: 5, bottom: 5),
    label: Text('Blog'),
    icon: Icon(Icons.article),
  ),
  NavigationRailDestination(
    padding: EdgeInsets.only(top: 5, bottom: 5),
    label: Text('News'),
    icon: Icon(Icons.newspaper_outlined),
  ),
  NavigationRailDestination(
    padding: EdgeInsets.only(top: 5, bottom: 5),
    label: Text('Statistics'),
    icon: Icon(Icons.query_stats_outlined),
  ),
  NavigationRailDestination(
    padding: EdgeInsets.only(top: 5, bottom: 5),
    label: Text('Activity'),
    icon: Icon(Icons.timelapse_outlined),
  ),
  NavigationRailDestination(
    padding: EdgeInsets.only(top: 5, bottom: 20),
    label: Text('Settings'),
    icon: Icon(Icons.settings),
  ),
];