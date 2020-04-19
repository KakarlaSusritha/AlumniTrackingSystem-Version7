// // import 'package:alumni_tracking_system/pages/changePassword.dart';
// // import 'package:alumni_tracking_system/pages/home.dart';
// // import 'package:alumni_tracking_system/pages/profile.dart';
// // import 'package:alumni_tracking_system/pages/profileEdit.dart';
// // import 'package:alumni_tracking_system/pages/selectDept.dart';
// // import 'package:alumni_tracking_system/pages/settings.dart';
// // import 'package:alumni_tracking_system/pages/signin.dart';
// // import 'package:alumni_tracking_system/services/auth.service.dart';
// // import 'package:flutter/material.dart';

// // AuthService appAuth = new AuthService();

// // void main() async {
// //   Widget _defaultHome = new Start();
// //   bool _result = await appAuth.login();
// //   if (_result) {
// //     _defaultHome = new Home();
// //   }
// //   runApp(new MaterialApp(
// //     title: 'App',
// //     home: _defaultHome,
// //     routes: <String, WidgetBuilder>{
// //       '/welcome' : (BuildContext context) =>  new Start(),
// //       '/Home': (BuildContext context) => new Home(),
// //       '/login': (BuildContext context) => new LoginPage(),
// //       '/profile': (BuildContext context) => new Profile(),
// //       '/profileEdit': (BuildContext context) => new ProfileEdit(),
// //       '/dept': (BuildContext context) => new Dept(),
// //       '/changePassword' : (BuildContext context) => new ChangePassword(),
// //       '/settings': (BuildContext context) => new SettingsPage(),
// //     },
// //   ));
// // }

// //   class Start extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;
// //     return new Scaffold(
// //       body: Container(
// //       decoration: BoxDecoration(
// //             // color: const Color(0xff7c94b6),
// //             image: DecorationImage(
// //               //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.screen),
// //               image: AssetImage('assets/bvrithclg.jpeg'), 
// //               //NetworkImage('https://images.unsplash.com/photo-1517030330234-94c4fb948ebc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1275&q=80'),
// //               fit: BoxFit.cover,
// //             ),
// //       ),
// //       child: new Column(
// //       mainAxisAlignment: MainAxisAlignment.start,    
// //       children:[
// //         Row(
// //                 children: [
// //               Container(
// //                 margin: EdgeInsets.only(left: 100,top: 200.0, bottom: 0.0, right:0.0),
// //                 child: Column(
// //       children: <Widget>[



// //             Container(  
// //                 margin: EdgeInsets.only(left: 10.0,top: 10.0, bottom: 10.0, right:0.0),
// //                 child:  Text("BVRITH", style: new TextStyle(fontFamily: 'DancingScript', fontWeight: FontWeight.bold, fontSize: 30.0 )),
// //                 ),
    
// //                   //
            
// //              Container(  
// //                margin: EdgeInsets.only(left: 0.0,top: 40.0, bottom: 50.0, right:0.0),
// //                 child:  Text("WELCOME", style: new TextStyle( fontWeight: FontWeight.bold, fontSize: 30.0 )) 
// //             ),
// //              RaisedButton(
// //               onPressed: (){
// //                  Navigator.of(context).pushNamed('/login');
// //               },
// //               child: Text('Log in',
// //                 style: TextStyle (fontSize: 20.0),
                
// //               ),
// //                     textColor: Colors.white,
// //                     color: Colors.green,   
// //              )
// //       ]
// //                 )
// //               )
// //                 ]
// //         )
// //       ]
// //       )
// //       )
// //     );
// //   }
// //   }
// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart' as words;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SeachAppBarRecipe',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SeachAppBarRecipe(title: 'SeachAppBarRecipe'),
//     );
//   }
// }

// class SeachAppBarRecipe extends StatefulWidget {
//   SeachAppBarRecipe({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _SearchAppBarRecipeState createState() => _SearchAppBarRecipeState();
// }

// class _SearchAppBarRecipeState extends State<SeachAppBarRecipe> {
//   final List<String> kWords;
//   _SearchAppBarDelegate _searchDelegate;

//   //Initializing with sorted list of english words
//   _SearchAppBarRecipeState()
//       : kWords = List.from(Set.from(words.all))
//     ..sort(
//           (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
//     ),
//         super();


//   @override
//   void initState() {
//     super.initState();
//     //Initializing search delegate with sorted list of English words
//     _searchDelegate = _SearchAppBarDelegate(kWords);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Word List'),
//         actions: <Widget>[
//           //Adding the search widget in AppBar
//           IconButton(
//             tooltip: 'Search',
//             icon: const Icon(Icons.search),
//             //Don't block the main thread
//             onPressed: () {
//               showSearchPage(context, _searchDelegate);
//             },
//           ),
//         ],
//       ),

//     );
//   }

//   //Shows Search result
//   void showSearchPage(BuildContext context,
//       _SearchAppBarDelegate searchDelegate) async {
//     final String selected = await showSearch<String>(
//       context: context,
//       delegate: searchDelegate,
//     );

//     if (selected != null) {
//       Scaffold.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Your Word Choice: $selected'),
//         ),
//       );
//     }
//   }
// }

// //Search delegate
// class _SearchAppBarDelegate extends SearchDelegate<String> {
//   final List<String> _words;
//   final List<String> _history;

//   _SearchAppBarDelegate(List<String> words)
//       : _words = words,
//   //pre-populated history of words
//         _history = <String>['apple', 'orange', 'banana', 'watermelon'],
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
// }
import 'package:flutter/material.dart';
import 'package:alumni_tracking_system/services/authentication.dart';
import 'package:alumni_tracking_system/pages/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
