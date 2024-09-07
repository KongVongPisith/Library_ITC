import 'package:flutter/material.dart';
import 'package:itc_library/model/book_model.dart';
import 'package:itc_library/repo/book_repo.dart';
import 'package:itc_library/view/bookList.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';


class Book_category extends StatefulWidget {
  const Book_category({super.key});

  @override
  State<Book_category> createState() => _Book_categoryState();
}

class _Book_categoryState extends State<Book_category> {

  List<Book_model> book =[];
  Book_repo book_repo = Book_repo();

  @override
  void initState() {
    getBook();
    super.initState();
  }

  Future<void> getBook() async{
    await book_repo.getBook_test();
    setState(() {
      book = book_repo.book_model;
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
        appBar: Back_appBar(context, 'Book Category'),
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
            itemCount: book_repo.category.length,
            itemBuilder: (context, index){
              final category = book_repo.category[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>BookList(category: category,br: book_repo,)));
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
                              category.cover,
                              fit: BoxFit.fill,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Expanded(
                            child: Text(
                              category.name,
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