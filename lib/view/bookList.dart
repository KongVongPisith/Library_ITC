import 'package:flutter/material.dart';
import 'package:itc_library/model/book_model.dart';
import 'package:itc_library/repo/book_repo.dart';
import 'package:itc_library/repo/fileDownload.dart';
import 'package:itc_library/view/bookDetails.dart';
import 'package:itc_library/widget/back_appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:share_plus/share_plus.dart';
import '../model/book_category.dart';

class BookList extends StatefulWidget {
  final Category category;
  final Book_repo br;

  BookList({required this.category, required this.br});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {

  List<Book_model> bt = [];
  bool isLoading = true;
  final DownloadFile df = DownloadFile();

  Future<void> fetchBooks() async {
    await widget.br.getBooksByCategory(widget.category.id);
    setState(() {
      isLoading = false;
      bt = widget.br.book_model;
    });
    print("Fetched Books: ${bt.length}");
  }


  void filter(String query) {
    if (query.isEmpty) {
      setState(() {
        bt = widget.br.book_model;
      });
    } else {
      final filteredBooks = widget.br.book_model.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()) ||
            book.id.toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        bt = filteredBooks;
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
        appBar: Back_appBar(context,'Book'),
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
                  itemCount: bt.length,
                  itemBuilder: (context, index) {
                    final book = bt[index];
                    // bool isDownloading = downloadStates[index] ?? false;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context)=> Book_detail(book: book,)));
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
                                      book.image,
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
                                          book.title,
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        Spacer(),
                                        Text(
                                          'Author: ${book.author}',
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                        Text(
                                          // "Genre: ${book.genre.join(' ,')}",
                                          "Genre: ${book.genre}",
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
                                          await df.downloadFile(context, book.pdf, book.title, index);
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

// onPressed: isDownloading ? null
//     : () async {
//   await df.downloadFile(context, book.pdf, book.title, index);
//   // await _downloadFile(context, book.pdf, book.title, index);
// },