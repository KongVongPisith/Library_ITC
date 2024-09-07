import 'package:flutter/material.dart';
import 'package:itc_library/model/department.dart';
import 'package:itc_library/model/thesis_model.dart';
import 'package:itc_library/repo/fileDownload.dart';
import 'package:itc_library/repo/thesis_repo.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:share_plus/share_plus.dart';

import 'pdf_view.dart';

class Thesis_list extends StatefulWidget {
  final Department department;
  final Thesis_repo thesis_repo;
  const Thesis_list({required this.department, required this.thesis_repo});

  @override
  State<Thesis_list> createState() => _Thesis_listState();
}

class _Thesis_listState extends State<Thesis_list> {

  List<Thesis_model> thesis_model = [];
  bool isLoading = true;
  final DownloadFile df = DownloadFile();

  Future<void> fetchThesis() async {
    await widget.thesis_repo.getThesisByDepartment(widget.department.id);
    setState(() {
      isLoading = false;
      thesis_model = widget.thesis_repo.thesis_model;
    });
    print("Fetched Books: ${thesis_model.length}");
  }


  void filter(String query) {
    if (query.isEmpty) {
      setState(() {
        thesis_model = widget.thesis_repo.thesis_model;
      });
    } else {
      final filteredBooks = widget.thesis_repo.thesis_model.where((thesis) {
        return thesis.studentName.toLowerCase().contains(query.toLowerCase()) ||
            thesis.subject.toLowerCase().contains(query.toLowerCase()) ||
            thesis.id.toString().toLowerCase().contains(query.toLowerCase()) ||
            thesis.topic.toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        thesis_model = filteredBooks;
      });
    }
  }

  @override
  void initState() {
    fetchThesis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: Back_appBar(context,'Thesis List'),
        drawer: Drawer_theme(context),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        alignLabelWithHint: false,
                        hintText: 'Search...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        // prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.search, size: 35,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (query) {
                        filter(query);
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: thesis_model.length,
                  itemBuilder: (context, index) {
                    final book = thesis_model[index];
                    // bool isDownloading = downloadStates[index] ?? false;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context)=> Pdf_view(pdf: book.pdf,))
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5,),
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      book.cover,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book.topic,
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        Spacer(),
                                        Text(
                                          'Author: ${book.studentName}',
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                        Text(
                                          // "Genre: ${book.genre.join(' ,')}",
                                          "Genre: ${book.subject}",
                                          style: Theme.of(context).textTheme.bodySmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children:<Widget> [
                                    IconButton(
                                        onPressed: () {
                                          Share.share(book.pdf);
                                        },
                                        icon:
                                        Icon(Icons.share_outlined)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons
                                            .favorite_outline_rounded)),
                                    IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            df.downloadStates[index]=true;
                                          });
                                          await df.downloadFile(context, book.pdf, book.topic, index);
                                          setState(() {
                                            df.downloadStates[index]=false;
                                          });
                                        },
                                        icon: df.isDownloading(index) ?
                                        SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                          ),
                                        ): Icon(Icons.download)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
