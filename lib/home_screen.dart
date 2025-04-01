import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_databases/boxes/boxes.dart';
import 'package:hive_databases/models/notes_model.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {




  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('database'),
      ),
      body: Column(
        children: [
            FutureBuilder(future: Hive.openBox('shaban') , builder: (context, snapshot){
                return Text(snapshot.data?.get('name').toString() ?? 'no');
                  
            })

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
             
       

      }, child: Icon(Icons.add),),
    );
  }

    Future<void> _showMyDialog(){
      return showDialog(context: context, builder: (context){
          return AlertDialog(
            
            title: Text('Add Notes'),
                    content: SingleChildScrollView(
                      child:ValueListenableBuilder<Box<NotesModel>>(
                        valueListenable: Boxes.getData().listenable(),
                         builder: (context, box , _){
                           var data = box.values.toList().cast<NotesModel>();
                              return ListView.builder(
                                  itemCount: box.length
                                ,itemBuilder: (context, index){
                                  return Container(
                                    height: 100,
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                          Text(data[index].title.toString()),
                                            Spacer(),
                                            InkWell(
                                                onTap: (){  
                                                      delete(data[index]);
                                                },
                                              child: Icon(Icons.edit)),
                                            SizedBox(width: 25,),
                                          Text(data[index].description.toString())

                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );

                              });

                      })
                    ),

                  actions: [

                            
                    TextButton(onPressed: (){
                          final data = NotesModel(title: titleController.text, description: descriptionController.text);

                          final box = Boxes.getData();
                          box.add(data);
                          titleController.clear();
                          descriptionController.clear();
                          // data.save();

                    }, child: Text('add')),
                    TextButton(onPressed: (){

                    }, child: Text('delete'))
                  ],
          );


      });
    }

    void delete(NotesModel notesModel)async{
      await notesModel.delete();

    }

   void update (NotesModel notesModel, ) async {
   
   }
}