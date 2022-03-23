import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'assetloader.dart';
import 'customer_bloc.dart';
import 'locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  await locator.allReady();

  final directory = await getApplicationDocumentsDirectory();

  await locator.allReady();
  WidgetsFlutterBinding.ensureInitialized();
   bool value = await locator.get<languageCheck>().checkLanguage();
   await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    child:  const MyApp(),
    supportedLocales: const [Locale('ar', 'AR'), Locale('en', 'US')],
    path:   value ?directory.uri.path :"assets/lang",
      assetLoader:  value?MyAssetLoader():const RootBundleAssetLoader(),
    startLocale: const Locale('en', 'US'),
    saveLocale:  true,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerCubit>(
          create: (BuildContext context) => CustomerCubit(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
               Text("CustomerCode".tr().toString()),
               Text(EasyLocalization.of(context)!.parent.path),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          CustomerCubit.get(context).getCustomers();

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
