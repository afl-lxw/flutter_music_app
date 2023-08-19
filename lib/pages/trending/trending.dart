import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  bool _isBVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transition Example')),
      body: Stack(
        children: [
          Column(
            children: [
              AComponent(),
              SizedBox(height: 20),
              BComponent(visible: _isBVisible),
            ],
          ),
          if (_isBVisible) TransitionAnimation(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isBVisible = true;
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

class AComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(left: 50),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.blue,
      ),
      child: Center(child: Text('A Component')),
    );
  }
}

class BComponent extends StatelessWidget {
  final bool visible;

  BComponent({required this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        child: Center(child: Text('B Component')),
      ),
    );
  }
}

class TransitionAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromLTRB(50, 50, 0, 0),
        end: RelativeRect.fromLTRB(150, 150, 0, 0),
      ).animate(CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeInOut,
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeInOut,
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green,
          ),
          child: Center(child: Text('Transitioned')),
        ),
      ),
    );
  }
}
