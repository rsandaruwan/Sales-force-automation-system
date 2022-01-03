import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sfasystem/services/notification_services.dart';
import 'package:sfasystem/services/theme_services.dart';
import 'package:get/get.dart';
import 'package:sfasystem/ui/add_task_bar.dart';
import 'package:sfasystem/ui/theme.dart';
import 'package:sfasystem/ui/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:sfasystem/controllers/task_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now() ;
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState(){
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTasks(),

        ],
      ),
    );
  }

  _showTasks(){
    return Expanded(
        child: Obx((){
          return ListView.builder(
            itemCount: _taskController.taskList.length,

            itemBuilder: (_, context){
              print(_taskController.taskList.length);
            return Container(
              width:100,
              height: 50,
              color: Colors.red,
              margin: const EdgeInsets.only(bottom: 10),
            );
          });
        }),
    );
  }


  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top:20, left: 20),
      child:DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle:GoogleFonts.lato(
          textStyle:  TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle:GoogleFonts.lato(
          textStyle:  TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle:GoogleFonts.lato(
          textStyle:  TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date){
          _selectedDate = date;

        },

      ),

    ) ;
  }

  _addTaskBar(){
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 12, top: 10),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMMd().format(DateTime.now()),
                    style:subHeadingStyle,
                  ),
                  Text("Today",
                    style:headingStyle,
                  )
                ],
              ),
            ),
            MyButton(lable: "+ Add Task", onTap: ()=> Get.to(AddTaskPage()))
          ]
        ),
      );
  }
  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body:Get.isDarkMode? "Activated Light Theme":"Activated Dark Theme"
          );
        },
        child: Icon(Get.isDarkMode? Icons.wb_sunny_outlined:Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode? Colors.white: Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
        backgroundImage: AssetImage(
        "images/profile.png"
        ),
      ),

        SizedBox( width: 20,),
      ],
    );
  }
}





