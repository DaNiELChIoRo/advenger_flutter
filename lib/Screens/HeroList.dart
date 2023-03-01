import 'package:advengers/bloc/HeroState.dart';
import 'package:advengers/Models/Hero.dart';
import 'package:bloc/bloc.dart';
import 'package:advengers/bloc/HeroEvent.dart';
import 'package:flutter/material.dart';

class HeroList extends StatelessWidget {
  const HeroList(
      {Key? key, required this.scrollController, required this.state})
      : super(key: key);

  final ScrollController scrollController;
  final HeroLoaded state;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: state.hasReachedMax
            ? state.characters.length
            : state.characters.length + 1,
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index >= state.characters.length) return BottomLoader();

          return ListTile(
              title: Text(
                state.characters[index].name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // title: Text(state.characters[index.])
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            HeroDetail(hero: state.characters[index])));
              });
        },
        separatorBuilder: (context, index) => Divider());
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
          child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      )),
    );
  }
}

class HeroDetail extends StatelessWidget {
  const HeroDetail({Key? key, required this.hero}) : super(key: key);

  final Character hero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar(
        icon: Icons.arrow_back,
        text: hero.name,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
          bottom: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20,
                right: 20,
                bottom: 0,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Image.network(hero.thumbnail.path +
                          "." +
                          hero.thumbnail.characterExtension),
                      Text(
                        hero.description,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}

AppBar SimpleAppbar(
    {required IconData icon,
    required String text,
    required VoidCallback onPressed}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Color.fromARGB(255, 20, 30, 217),
    centerTitle: false,
    title: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
    ),
    leading: IconButton(
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      onPressed: () {
        onPressed();
      },
    ),
  );
}
