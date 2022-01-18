import 'package:flutter/cupertino.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget child;

  CustomRoute({this.child})
      : super(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (context, animation, secondAnimation) => child);

  @override
  Widget buildTranstition(BuildContext context, Animation<double> animation,
          Animation<double> secondAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
}
