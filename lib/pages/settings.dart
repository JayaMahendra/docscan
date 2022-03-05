import 'package:docscan/blocs/Auth_bloc.dart';
import 'package:docscan/event/auth_event.dart';
import 'package:docscan/pages/account.dart';
import 'package:docscan/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  late final AuthBloc authBloc;

  // const SettingPage({Key? key, required this.authBloc}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AuthBloc get _authBloc => widget.authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: SettingForm(
        authBloc: _authBloc,
      ),
    );
  }
}

class SettingForm extends StatefulWidget {
  final AuthBloc authBloc;

  SettingForm({Key? key, required this.authBloc}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: widget.authBloc,
        builder: (context, state) {
          return Container(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Setting',
                        style: title,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30, left: 30),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.profile_circled,
                              size: 80,
                              color: purple,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jaya Mahendra',
                                  style: text,
                                ),
                                Text(
                                  "Lorem ipsum ",
                                  style: desc,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 40),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AccountPage()),
                                  );
                                },
                                child: menuSetting(
                                    'Account', 'Lorem ipsum dolor sit amet'),
                              ),
                              Padding(padding: EdgeInsets.only(top: 25)),
                              menuSetting('Go To Website',
                                  'Lorem ipsum dolor sit amet'),
                              Padding(padding: EdgeInsets.only(top: 25)),
                              menuSetting(
                                  'About App', 'Lorem ipsum dolor sit amet'),
                              Padding(padding: EdgeInsets.only(top: 25)),
                              menuSetting(
                                  'Log Out', 'Lorem ipsum dolor sit amet'),
                              GestureDetector(
                                onTap: _logout,
                                child: menuSetting(
                                    'Log Out', 'Lorem ipsum dolor sit amet'),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Row menuSetting(String data, String data1) {
    return Row(children: [
      Icon(
        Icons.circle_rounded,
        color: purple,
        size: 40,
      ),
      Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(data, style: text), Text(data1, style: desc)]),
      ),
    ]);
  }

  void _logout() {
    widget.authBloc.add(LoggedOut());
  }
}
