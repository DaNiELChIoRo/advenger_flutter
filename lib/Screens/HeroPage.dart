import 'package:advengers/bloc/HeroEvent.dart';
import 'package:advengers/bloc/HeroState.dart';
import 'package:advengers/bloc/hero_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:advengers/bloc/hero_bloc.dart';
import 'package:advengers/Screens/HeroList.dart';

class HeroPage extends StatelessWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hero List")),
        body: BlocProvider<HeroBloc>(
            create: (context) => HeroBloc()..add(HeroFetched()),
            child: const HeroBody()));
  }
}

class HeroBody extends StatefulWidget {
  const HeroBody({Key? key}) : super(key: key);

  @override
  _HeroBodyState createState() => _HeroBodyState();
}

class _HeroBodyState extends State<HeroBody> {
  ScrollController _scrollController = ScrollController();
  late HeroBloc _heroBloc;

  @override
  void initState() {
    super.initState();
    _heroBloc = context.read<HeroBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroBloc, HeroState>(builder: (context, state) {
      if (state is HeroInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is HeroLoaded) {
        if (state.characters.isEmpty) {
          return Center(
            child: Text("No Heros :/"),
          );
        }
        return RefreshIndicator(
            onRefresh: _onRefresh,
            child: HeroList(scrollController: _scrollController, state: state));
      }

      return Center(
        child: Text("Error Fetched Heros"),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _heroBloc..add(HeroRefresh());
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) _heroBloc..add(HeroFetched());
  }
}
