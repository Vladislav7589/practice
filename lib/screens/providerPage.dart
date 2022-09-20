import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practic/providers/colorProvider.dart';
import 'package:practic/providers/countProvider.dart';
import 'package:practic/providers/eventProvider.dart';
import 'package:practic/providers/usersProvider.dart';
import 'package:provider/provider.dart';

import 'dart:convert';

import 'package:flutter/services.dart';

class ProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Providers();
  }
}

class Providers extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountProvider()),
        ChangeNotifierProvider(create: (context) => ColorProvider()),
        FutureProvider<List<User>>(
          initialData: const [],
          create: (context) async => UserProvider().loadUserData(),
        ),
        StreamProvider<int>(
          initialData: 0,
          create: (context) => EventProvider().intStream(),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Consumer<ColorProvider>(
              builder: (context, value, child){
                return AppBar(
                  title:  Text("Provider"),
                  backgroundColor: value.color,
                  centerTitle: true,
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(icon: Icon(Icons.add)),
                      Tab(icon: Icon(Icons.person)),
                      Tab(icon: Icon(Icons.message)),
                    ],
                  ),
                );
              }
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              MyCountPage(),
              MyUserPage(),
              ColorPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCountPage extends StatelessWidget {
  const MyCountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountProvider state = Provider.of<CountProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ChangeNotifierProvider',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 50),
            Text('${state.counterValue}',
                style: Theme.of(context).textTheme.headline4),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () => state.decrementCount(),
                ),
                Consumer<CountProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.green,
                      onPressed: () => value.incrementCount(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyUserPage extends StatelessWidget {
  const MyUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Загрузка пользователей из файла:',
              style: TextStyle(fontSize: 17)),
        ),
        Consumer<List<User>>(
          builder: (context, List<User> users, _) {
            return Expanded(
              child: users.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 50,
                            color: Colors.grey[(index * 200) % 400],
                            child: Center(
                                child: Text(
                                    '${users[index].firstName} ${users[index].lastName} | ${users[index].website}')));
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}

// Event page (counting)
class MyEventPage extends StatelessWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<int>(context);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('StreamProvider', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 50),
        Text(value.toString(), style: Theme.of(context).textTheme.headline4)
      ],
    ));
  }
}

class ColorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
                Consumer<ColorProvider>(
                  builder: (context, state, child) {
                    return  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                              decoration: BoxDecoration(// added
                                color: state.color,
                                borderRadius: BorderRadius.circular(state.enable ? 25 : 0),
                              ),
                              width: state.enable ? 100.0 : 200.0,
                              height: state.enable ? 100.0 : 200.0,
                              duration: const Duration(seconds: 1),

                          ),
                          Switch(
                              value: state.enable,
                              activeColor: state.color,
                              onChanged: (value) {
                                    state.enable = value;
                                    state.changeColor();
                              }
                          ),
                        ],
                    );
                  },
                )
    );
  }
}

// User Model
class User {
  final String firstName, lastName, website;

  const User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        website = json['website'];
}

// User List Model
class UserList {
  final List<User> users;

  UserList(this.users);

  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((user) => User.fromJson(user)).toList();
}
