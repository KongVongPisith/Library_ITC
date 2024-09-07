import 'package:flutter/material.dart';
import 'package:itc_library/model/journal_model.dart';
import 'package:itc_library/repo/journal_repo.dart';
import 'package:itc_library/view/journal_list.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';
class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {

  List<Journal_model> journal =[];
  Journal_repo jr = Journal_repo();

  @override
  void initState() {
    getJournal();
    super.initState();
  }

  Future<void> getJournal() async{
    await jr.getJournal();
    setState(() {
      journal = jr.journal_data;
    });
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final String background;
    final theme = Theme.of(context);
    if(theme.brightness == Brightness.light){
      background = Custom_theme.lightBackgroundImage;
    }else{
      background = Custom_theme.darkBackgroundImage;
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: Back_appBar(context, 'Journal Fields'),
        drawer: Drawer_theme(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: (itemWidth / itemHeight),
              mainAxisExtent: 300,
            ),
            itemCount: jr.field_data.length,
            itemBuilder: (context, index){
              final field = jr.field_data[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>
                            Journal_List(fields: field, jr: jr)
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              field.cover,
                              fit: BoxFit.fill,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Expanded(
                            child: Text(
                              field.fieldName,
                              style: theme.textTheme.titleMedium,
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
