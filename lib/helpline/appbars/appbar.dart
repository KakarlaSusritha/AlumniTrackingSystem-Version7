import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as words;
class CustomAppBar extends StatefulWidget with PreferredSizeWidget{
 CustomAppBar({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _CustomAppBar(auth, logoutCallback, userId);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBar extends State<CustomAppBar> {
  BaseAuth auth;
  VoidCallback logoutCallback;
  String userId;
   final List<String> kWords;
  //_SearchAppBarDelegate _searchDelegate;
  _CustomAppBar(this.auth, this.logoutCallback, this.userId): kWords = List.from(Set.from(words.all))
    ..sort(
          (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
    ),
        super();
        
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
      
  @override
  void initState() {
    super.initState();
  //  _searchDelegate = _SearchAppBarDelegate(kWords);
  }
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("");
  
  @override 
  Widget build(BuildContext context) {
    //print(this.userId);
    return AppBar(
        backgroundColor: Colors.lightBlue,
        actions: <Widget> [
          
          // InkWell(
          //   onTap: (){},
          //   child: SizedBox(
          //     width: 40.0,
              
          //   ),
          // ),
          IconButton(icon: Icon(Icons.search),
            onPressed: (){
              //showSearchPage(context, _searchDelegate);
              setState(() {
                if(this.cusIcon.icon == Icons.search){
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color:Colors.white,
                        fontSize:16.0,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );

                }
                else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("");

                }
              });
            },),
            new FlatButton(
                child: Icon(Icons.exit_to_app, color: Colors.white,),
                onPressed: signOut)
        ],
        titleSpacing: 0.0,
        title: cusSearchBar,
      );
  }
   signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } catch (e) {
      print(e);
    }
  }
//    void showSearchPage(BuildContext context,
//       _SearchAppBarDelegate searchDelegate) async {
//     final String selected = await showSearch<String>(
//       context: context,
//       delegate: searchDelegate,
//     );
//   }
// }
// //Search delegate
// class _SearchAppBarDelegate extends SearchDelegate<String> {
//   final List<String> _words;
//   final List<String> _history;

//   _SearchAppBarDelegate(List<String> words)
//       : _words = words,
//   //pre-populated history of words
//         _history = <String>[''],
//         super();

//   // Setting leading icon for the search bar.
//   //Clicking on back arrow will take control to main page
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       tooltip: 'Back',
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         //Take control back to previous page
//         this.close(context, null);
//       },
//     );
//   }

//   // Builds page to populate search results.
//   @override
//   Widget buildResults(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text('===Your Word Choice==='),
//             GestureDetector(
//               onTap: () {
//                 //Define your action when clicking on result item.
//                 //In this example, it simply closes the page
//                 this.close(context, this.query);
//               },
//               child: Text(
//                 this.query,
//                 style: Theme.of(context)
//                     .textTheme
//                     .display2
//                     .copyWith(fontWeight: FontWeight.normal),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Suggestions list while typing search query - this.query.
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final Iterable<String> suggestions = this.query.isEmpty
//         ? _history
//         : _words.where((word) => word.startsWith(query));

//     return _WordSuggestionList(
//       query: this.query,
//       suggestions: suggestions.toList(),
//       onSelected: (String suggestion) {
//         this.query = suggestion;
//         this._history.insert(0, suggestion);
//         showResults(context);
//       },
//     );
//   }

//   // Action buttons at the right of search bar.
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return <Widget>[
//       query.isNotEmpty ?
//       IconButton(
//         tooltip: 'Clear',
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           showSuggestions(context);
//         },
//       ) : IconButton(
//         icon: const Icon(Icons.mic),
//         tooltip: 'Voice input',
//         onPressed: () {
//           this.query = 'TBW: Get input from voice';
//         },

//       ),
//     ];
//   }
// }

// // Suggestions list widget displayed in the search page.
// class _WordSuggestionList extends StatelessWidget {
//   const _WordSuggestionList({this.suggestions, this.query, this.onSelected});

//   final List<String> suggestions;
//   final String query;
//   final ValueChanged<String> onSelected;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme.subhead;
//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (BuildContext context, int i) {
//         final String suggestion = suggestions[i];
//         return ListTile(
//           leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
//           // Highlight the substring that matched the query.
//           title: RichText(
//             text: TextSpan(
//               text: suggestion.substring(0, query.length),
//               style: textTheme.copyWith(fontWeight: FontWeight.bold),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: suggestion.substring(query.length),
//                   style: textTheme,
//                 ),
//               ],
//             ),
//           ),
//           onTap: () {
//             onSelected(suggestion);
//           },
//         );
//       },
//     );
//   }
}