import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  HomeViewModel homeViewModel = HomeViewModel();


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/cardapio.png'),
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.amber,
                    )
                  ],
                ),
            ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                          offset: Offset(2, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      hintText: 'Search',
                      suffixIcon: GestureDetector(child: Image.asset('assets/filtro.png')),
                        prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                          onPressed: () {
                          homeViewModel.fetchAllBlocos();
                      },
                    ),
                      border: InputBorder.none, // Remove a borda
                    enabledBorder: InputBorder.none, // Remove a borda quando inativo
                    focusedBorder: InputBorder.none, // Remove a borda quando focado
                  ),
                ),
                ),
              ),
            FutureBuilder(
              future: Provider.of<HomeViewModel>(context, listen: false).fetchAllBlocos(),
              builder: (context, snapshot) {
              _connectionState(snapshot);
              final blocos = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 600,
                  child: ListView.builder(
                    itemCount: blocos.length,
                    itemBuilder: (context, index) {
                      var bloco = blocos[index];
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                                 boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                      offset: Offset(2, 4), // Shadow position
                                    ),
                                  ],
                              ),
                              
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(bloco.title, style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(bloco.address, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                        Text(bloco.dateTime != null ? bloco.dateTime!.hour.toString() + ':' + bloco.dateTime!.minute.toString() : 'Horário Indefinido' ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            
                            ),
                          ),
                        );
                    },
                  ),
                ),
                // child: Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Image.asset('assets/cardapio.png'),
                //         Container(
                //           width: 40,
                //           height: 40,
                //           color: Colors.amber,
                //         )
                //       ],
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(10),
                //       child: Container(
                //         height: 50,
                //         padding: EdgeInsets.symmetric(horizontal: 8.0),
                //         decoration: const BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.all(Radius.circular(20)),
                //            boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey,
                //               blurRadius: 10,
                //                offset: Offset(2, 4), // Shadow position
                //             ),
                //           ],
                //         ),
                //         child: TextField(
                //           controller: _searchController,
                //           decoration: InputDecoration(
                //             fillColor: Colors.white,
                //             hoverColor: Colors.white,
                //             hintText: 'Search',
                //             suffixIcon: GestureDetector(child: Image.asset('assets/filtro.png')),
                //              prefixIcon: IconButton(
                //               icon: Icon(Icons.search),
                //                 onPressed: () {
                //                 homeViewModel.fetchAllBlocos();
                //             },
                //           ),
                //            border: InputBorder.none, // Remove a borda
                //           enabledBorder: InputBorder.none, // Remove a borda quando inativo
                //           focusedBorder: InputBorder.none, // Remove a borda quando focado
                //         ),
                //       ),
                //       ),
                //     )
                //   ],
                //),
                );
                }
              
            ),
          ],
        ),
      )
    );
  }
}

Widget _connectionState(var snapshot){
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
      child: CircularProgressIndicator(),
    );
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {

    // Handle errors
      return Center(
      child: Text('Error: ${snapshot.error}'),
    );
    }
  }
  return const Center(
    child: Text('Something went wrong!'),
  );
}

// List<Bloco> buildListsWithFilters(HomeViewModel viewModel, var snapshot){
//   List<Bloco> displayedContacts = [];
//    displayedContacts = viewModel.fetchAllBlocos();
//   //  if(viewModel.showOnlyFavorites == true){
//   //    
//   //   }else{
//   //    if(viewModel.showAll && snapshot.data != null){
//   //     List<ContactModel> allContacts = snapshot.data!;
//   //     displayedContacts = allContacts;
//   //    }
//   //   }
//   //   if(viewModel.showOnlyArchives){
//   //     displayedContacts = viewModel.contactsArchives;
//   //   }
//     return displayedContacts;
// }