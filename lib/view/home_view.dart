import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/view/bloco_list.dart';
import 'package:carnaval_no_bolso_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  HomeViewModel homeViewModel = HomeViewModel();
  LatLng? _currentPosition;
  final MapController _mapController = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.getCurrentLocation(_currentPosition, _mapController);
  
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Provider.of<HomeViewModel>(context, listen: false).fetchAllBlocos(),
          builder: (context, snapshot) {
            if(snapshot.data == null){
              return Center(child: _connectionState(snapshot));
            }
          return Stack(
            children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FlutterMap(
                mapController: _mapController,
                options:  MapOptions(
                initialCenter: _currentPosition ?? LatLng(-8.0476, -34.8770),
                initialZoom: 15.0
              ),
                children: [
                 TileLayer( // Bring your own tiles
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
            userAgentPackageName: 'com.example.app', // Add your app identifier
            // And many more recommended properties
                 ),
          
            if (_currentPosition != null)
              MarkerLayer(
                markers: [
                  Marker(
                    child:  Icon(Icons.location_pin, color: Colors.red, size: 40),
                    width: 40.0,
                    height: 40.0,
                    point: _currentPosition!,
                    
                  ),
                ],
              ),
              ],
              
            ),
            
            
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/cardapio.png')),
              Padding(
              padding: const EdgeInsets.only(left:10, right: 10),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.amber,
                   ),
                ),
                ],
              ),
            ),
          
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
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
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                    width: MediaQuery.of(context).size.width,   
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: const Row(
                      children: [
                        Text("data")
                      ],
                    ),        
                                 // child:   SingleChildScrollView(
                    
                                 //   child: Column(
                                 //     mainAxisAlignment: MainAxisAlignment.center,
                                 //     children: [
                                 //       const Padding(
                                 //         padding: EdgeInsets.all(8.0),
                                 //         child: Row(
                                 //           children: [
                                 //             Icon(Icons.map),
                                 //             Padding(
                                 //               padding: EdgeInsets.all(8.0),
                                 //               child: Text("Blocos Próximos de você", style: TextStyle(
                                 //                 fontSize: 20
                                 //               )),
                                 //             ),
                                 //           ],
                                 //         ),
                                 //       ),
                                 //       FutureBuilder(
                                 //       future: Provider.of<HomeViewModel>(context, listen: false).fetchAllBlocos(),
                                 //       builder: (context, snapshot) {
                                    
                                 //       if(snapshot.data == null){
                                 //         return   Center(child: _connectionState(snapshot));
                                 //       }
                                 //       final blocos = snapshot.data!;
                                 //       return Padding(
                                 //         padding: const EdgeInsets.all(20),
                                 //         child: Container(
                                 //           height: 600,
                                 //           child: ListView.builder(
                                 //             physics: AlwaysScrollableScrollPhysics(),
                                 //             itemCount: blocos.length,
                                 //             itemBuilder: (context, index) {
                                 //               var bloco = blocos[index];
                                 //                 return GestureDetector(
                                 //                   child: Padding(
                                 //                     padding: const EdgeInsets.all(8.0),
                                 //                     child: Container(
                                 //                       width: 100,
                                 //                       height: 100,
                                 //                       decoration: BoxDecoration(
                                 //                         color: Colors.red,
                                 //                         borderRadius: BorderRadius.circular(20),
                                 //                          boxShadow: const [
                                 //                             BoxShadow(
                                 //                               color: Colors.grey,
                                 //                               blurRadius: 10,
                                 //                               offset: Offset(2, 4), // Shadow position
                                 //                             ),
                                 //                           ],
                                 //                       ),
                                        
                                 //                       child: Padding(
                                 //                         padding: const EdgeInsets.all(10),
                                 //                         child: Column(
                                 //                           mainAxisAlignment: MainAxisAlignment.end,
                                 //                           children: [
                                 //                             Text(bloco.title, style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),),
                                 //                             Row(
                                 //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 //                               children: [
                                 //                                 Text(bloco.address, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                 //                                 Text(bloco.dateTime != null ? bloco.dateTime!.hour.toString() + ':' + bloco.dateTime!.minute.toString() : 'Horário Indefinido' ),
                                 //                               ],
                                 //                             )
                                 //                           ],
                                 //                         ),
                                 //                       ),
                                      
                                 //                     ),
                                 //                   ),
                                 //                 );
                                 //             },
                                 //           ),
                                 //         ),
                                 //       );
                                 //                   }
                          
                                 //                 ),
                                 //     ],
                                 //   ),
                                 // ),
                   ),
                 ),
                ],
              ),
          
            
                ]
              );
                },
        ),
        
      ),
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