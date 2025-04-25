import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class TabCont extends StatefulWidget {
  const TabCont({super.key});

  @override
  State<TabCont> createState() => _tabContState();
}

class _tabContState extends State<TabCont> {
  @override
  Widget build(BuildContext context) {
   return DefaultTabController(length: 3,
       child:Scaffold(
     appBar: AppBar(
       title: Text('Tab Bar'),
       bottom: TabBar(tabs:
           [
             Tab(icon: Icon(Icons.insert_emoticon_sharp),),
             Tab(icon: Icon(Icons.add_call),),
             Tab(icon: Icon(Icons.adb_outlined),),
           ]
       ),
     ),
     body: TabBarView(children:
         [
           SlideInUp(
             from: 300,
             child: SizedBox(
               height: 100,
               width: 100,
               child: ElevatedButton(
                   onPressed:() {
                 showDialog(context: context, builder: (context){
                   return Center(
                     child: AlertDialog(
                       title: Text('Alert Box'),
                       content: Text('Demo'),
                       actions: [
                         IconButton(onPressed: () {
                           Navigator.pop(context);
                         }, icon: Icon(Icons.account_tree_outlined))
                       ],
                     ),
                   );
                 },);
               } , child: Text('AlertBox')),
             ),
           ),
           Image(image: AssetImage('assets/images/camara.jpg')),
           Image(image: AssetImage('assets/images/call.jpg')),

         ]
     ),

   ));
  }
}
