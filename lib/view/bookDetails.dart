import 'package:flutter/material.dart';
import 'package:itc_library/model/book_model.dart';
import 'package:itc_library/repo/fileDownload.dart';
import 'package:itc_library/view/pdf_view.dart';
import 'package:itc_library/widget/Detail_appBar.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:share_plus/share_plus.dart';

class Book_detail extends StatefulWidget {
  final Book_model book;
  const Book_detail({required this.book});

  @override
  State<Book_detail> createState() => _Book_detailState();
}

class _Book_detailState extends State<Book_detail> {

  DownloadFile df = DownloadFile();

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
        appBar: JustBack(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(
              parent: ScrollPhysics(),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 230,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Hero(
                        tag: widget.book.image,
                        child: Container(
                          height: 220,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.book.image),
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                widget.book.title,
                                maxLines: 4,
                                style: Theme.of(context).textTheme.titleMedium,
                                minFontSize: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              Text(
                                  'Author: ${widget.book.author}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Published: ${widget.book.published}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),

                            ],
                          )
                      ),
                      ],
                  ),
                ),
                SizedBox(height: 20,),
               Row(
                 children: <Widget> [
                   Container(
                     height: 50,
                     width: 200,
                     child: ButtonTheme(
                       child: MaterialButton(
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context)=> Pdf_view(pdf: widget.book.pdf,)));
                         },
                         child: Text(
                             'Read Book',
                           style: Theme.of(context).textTheme.bodyMedium,
                         ),
                         splashColor: Colors.blue,
                         color: Colors.white30,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                     ),
                   ),
                   Spacer(),
                   Container(
                     child: IconButton(
                       onPressed: (){},
                       icon: Icon(Icons.favorite_outline, size: 40,),
                     ),
                   ),
                   Container(
                     child: IconButton(
                         onPressed: () async {
                           setState(() {
                             df.downloadStates[widget.book.id]=true;
                           });
                           await df.downloadFile(context, widget.book.pdf, widget.book.title, widget.book.id);
                           setState(() {
                             df.downloadStates[widget.book.id]=false;
                           });
                         },
                         icon: df.isDownloading(widget.book.id) ?
                         SizedBox(
                           width: 20.0,
                           height: 20.0,
                           child: CircularProgressIndicator(
                             strokeWidth: 2.0,
                           ),
                         ): Icon(Icons.download,size: 40,)),
                   ),
                   Container(
                     child: IconButton(
                       onPressed: (){
                         Share.share(widget.book.pdf);
                       },
                       icon: Icon(Icons.share_outlined, size: 40,),
                     ),
                   ),
                 ],
               ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Description',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Text(
                  widget.book.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
