import 'package:flutter/material.dart';
import 'package:itc_library/model/journal_model.dart';
import 'package:itc_library/repo/fileDownload.dart';
import 'package:itc_library/repo/journal_repo.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:share_plus/share_plus.dart';

import '../model/field.dart';

class Journal_List extends StatefulWidget {
  final Fields fields;
  final Journal_repo jr;

  Journal_List({required this.fields, required this.jr});

  @override
  State<Journal_List> createState() => _BookListState();
}

class _BookListState extends State<Journal_List> {

  List<Journal_model> jm = [];
  bool isLoading = true;
  final DownloadFile df = DownloadFile();

  Future<void> fetchBooks() async {
    await widget.jr.getJournalByField(widget.fields.id);
    setState(() {
      isLoading = false;
      jm = widget.jr.journal_data;
    });
    print("Fetched Books: ${jm.length}");
  }


  void filter(String query) {
    if (query.isEmpty) {
      setState(() {
        jm = widget.jr.journal_data;
      });
    } else {
      final filteredJournals = widget.jr.journal_data.where((journal) {
        return journal.topic.toLowerCase().contains(query.toLowerCase()) ||
            journal.subject.toLowerCase().contains(query.toLowerCase()) ||
            journal.id.toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        jm = filteredJournals;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    fetchBooks();
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
        appBar: Back_appBar(context,'Journal List'),
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
                  itemCount: jm.length,
                  itemBuilder: (context, index) {
                    final journal = jm[index];
                    // bool isDownloading = downloadStates[index] ?? false;
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context, MaterialPageRoute(
                        //     builder: (context)=>
                        // ));
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
                                      journal.cover,
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
                                          journal.topic,
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        Spacer(),
                                        Text(
                                          'Author: ${journal.researcher}',
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                        Text(
                                          // "Genre: ${book.genre.join(' ,')}",
                                          "Subject: ${journal.subject}",
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
                                          Share.share(journal.pdf);
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
                                          await df.downloadFile(context, journal.pdf, journal.topic, index);
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
