import 'package:flutter/material.dart';
import 'package:hackathon_app/constants/app_size.dart';
import 'package:hackathon_app/constants/theme/app_colors.dart';
import 'package:hackathon_app/presentation/view/components/bottom_nav.dart';
import 'package:hackathon_app/presentation/view/components/common_button.dart';
import 'package:hackathon_app/presentation/view/components/common_textfield.dart';
import 'package:hackathon_app/presentation/view/model/bottom_nav_item_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final sampleTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSize.sm,
          children: <Widget>[
            const Text('ここから共通コンポーネントのサンプル'),
            CommonTextfield(
              controller: sampleTextEditingController,
              changeFunc: (value) {
                debugPrint(value);
              },
            ),
            CommonButton(
              children: Text(
                'サンプルだよ',
                style: TextStyle(color: AppColors.btnTextColor),
              ),
              tapFunc: () {
                debugPrint('サンプルだってば');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        itemList: [
          BottomNavItemModel(icon: Icon(Icons.home), labelText: 'Home'),
          BottomNavItemModel(icon: Icon(Icons.edit), labelText: 'Edit'),
          BottomNavItemModel(icon: Icon(Icons.settings), labelText: 'Setting'),
        ],
        tapFunc: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
