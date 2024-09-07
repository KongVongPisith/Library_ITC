import 'package:flutter/material.dart';
import 'package:itc_library/model/events_model.dart';
import 'package:itc_library/repo/events_repo.dart';
import 'package:itc_library/view/Event_detail.dart';
import 'package:itc_library/widget/Custom_sliverAppBar.dart';
import 'package:itc_library/widget/appBar.dart';
import 'package:itc_library/widget/drawer_component/drawer.dart';
import 'package:itc_library/widget/theme.dart';

class Event_page extends StatefulWidget {
  const Event_page({super.key});

  @override
  State<Event_page> createState() => _Event_pageState();
}

class _Event_pageState extends State<Event_page> {

  List<Events_model> events = [];
  Events_repo er = Events_repo();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    get_api();
  }

  Future<void> get_api()async{
    await er.getEvents();
    setState(() {
      events = er.event_model;
      loading = false;
    });
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        events = er.event_model;
      });
    } else {
      final filteredEvent = er.event_model.where((events) {
        return events.title.toLowerCase().contains(query.toLowerCase());
      }
      ).toList();
      setState(() {
        events = filteredEvent;
      });
    }
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
        appBar: Custom_appbar(context),
        drawer: Drawer_theme(context),
        body:loading?Center(
          child: CircularProgressIndicator(color: Theme.of(context).indicatorColor,),
        ): NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool isScroll) {
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
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Bitter_regular',
                          fontWeight: FontWeight.bold,
                          color: Colors.black12,
                        ),
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
                        filterSearch(query);
                      },
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Bitter_regular',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ];
            },

            body: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: BouncingScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context , index){
                  final ev = events[index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor,
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          ev.urlToImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            maxLines: 2,
                                              ev.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                          Spacer(),
                                          Text(
                                            ev.author,
                                            style: Theme.of(context).textTheme.bodySmall,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context)=>Event_detail(events_model: events[index])));
                    },
                  );
                })
          ),
      ),
    );
  }
}
