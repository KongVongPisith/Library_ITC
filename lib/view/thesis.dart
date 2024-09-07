import 'package:flutter/material.dart';
import 'package:itc_library/model/thesis_model.dart';
import 'package:itc_library/repo/thesis_repo.dart';
import 'package:itc_library/view/thesis_list.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';

class Thesis_category extends StatefulWidget {
  const Thesis_category({super.key});

  @override
  State<Thesis_category> createState() => _Thesis_categoryState();
}

class _Thesis_categoryState extends State<Thesis_category> {

  List<Thesis_model> thesis_model = [];
  Thesis_repo thesis_repo = Thesis_repo();

  Future<void> getThesis() async{
    await thesis_repo.getThesis();
    setState(() {
      thesis_model = thesis_repo.thesis_model;
    });
  }

  @override
  void initState() {
    getThesis();
    super.initState();
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
        appBar: Back_appBar(context, 'Thesis Category'),
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
            itemCount: thesis_repo.department_model.length,
            itemBuilder: (context, index){
              final department = thesis_repo.department_model[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>
                            Thesis_list(thesis_repo: thesis_repo, department: department, )
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
                              department.cover,
                              fit: BoxFit.fill,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Expanded(
                            child: Text(
                              department.name,
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
