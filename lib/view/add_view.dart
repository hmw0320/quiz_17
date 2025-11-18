import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {

  var value = Get.arguments ?? "__";
  late TextEditingController textEditingController;
  late List<String> imageName;
  late int selectedItem;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    imageName = [
      'images/pencil.png',
      'images/clock.png',
      'images/cart.png'
    ];
    selectedItem = 0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add View'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageName[selectedItem],
                  width: 100,
                  height: 150,
                  ),
                Container(
                  color: Colors.cyan[200],
                  width: 200,
                  height: 150,
                  child: CupertinoPicker(
                    itemExtent: 60,
                    scrollController: FixedExtentScrollController(initialItem: 0),
                    onSelectedItemChanged: (value) {
                      selectedItem = value;
                      setState(() {});
                    },
                    children: List.generate(
                      3,
                      (index) => Center(
                        child: Image.asset(
                          imageName[index],
                          width: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 40),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: '목록을 입력하세요'
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                  if(textEditingController.text.trim().isNotEmpty){
                    value[0] = imageName[selectedItem];
                    value[1] = textEditingController.text.trim();
                    value[2] = true;
                  }
                  setState(() {});
                Get.back(result: value);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5)
                )
              ),
              child: Text('OK')
            ),
          ],
        ),
      ),
    );
  }
}