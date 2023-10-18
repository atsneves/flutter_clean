import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:movies_clean/modules/search/presenter/blocs/search_bloc.dart';
import 'package:movies_clean/modules/search/presenter/blocs/states/state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  void onSubmitted(String value) {
    bloc.add(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Search User')),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onSubmitted: onSubmitted,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Buscar usuário github"),
          ),
        ),
        Expanded(
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is SearchInitial) {
                    return const Center(
                      child: Text("Para efetuar a busca, digite enter!",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    );
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SearchError) {
                    return const Center(
                      child: Text(
                        'Houve um erro na busca',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final list = (state as SearchSuccess).list;

                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, id) {
                        final item = list[id];
                        return ListTile(
                          title: Text(item.title.isEmpty ? "" : item.title),
                          tileColor:
                              id % 2 == 0 ? Colors.grey[100] : Colors.grey[200],
                          subtitle:
                              Text(item.content.isEmpty ? "" : item.content),
                          leading: item.img.isEmpty
                              ? Container()
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(item.img),
                                ),
                        );
                      });
                }))
      ]),
    );
  }
}
