

//定义路由表
import 'package:flutter/material.dart';
import 'package:hello_world/pages/ScaffoldRoute.dart';
import 'package:hello_world/pages/counterA.dart';
import 'package:hello_world/pages/counterB.dart';
import 'package:hello_world/pages/homePage.dart';
import 'package:hello_world/pages/TabBar.dart';

final routes = {
  '/': (context, {arguments}) => HomePage(),
  //不带参数路由
  '/counterA': (context, {arguments}) => CounterA(),
  //带参数路由
  '/counterB':(context, {arguments}) => CounterB(arguments: arguments),
  '/scaffold':(context, {arguments}) => ScaffoldRoute(),
  '/tabBar':(context, {arguments}) => TabBar1()
};