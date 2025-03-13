import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/model/bloco_location.dart';
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
  late Future<List<Bloco>> futureBlocos;
  final List<Bloco> blocos = [];
  late List<BlocoLocation> blocoLocationList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
   futureBlocos = homeViewModel.getCurrentLocation(_currentPosition, _mapController).then((_) {
    return homeViewModel.getNearestCarnivalBlock();
  });
  
  
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child) {
          return FutureBuilder<List<Bloco>>(
            future: futureBlocos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _connectionState(snapshot); 
                } else {
              blocos.addAll(snapshot.data!);
              

            return FutureBuilder<List<BlocoLocation>>(
              future: homeViewModel.getLatLongFromAddress(blocos),
              builder: (context, snapshot) {
                if(snapshot.data == null) {
                return _connectionState(snapshot);
              } else {
                blocoLocationList.addAll(snapshot.data!);
              
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
                    markers: blocoLocationList.map((bloco) {
                      return Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(bloco.lat, bloco.long),
                        child:  Icon(Icons.location_pin, color: Colors.red, size: 40),
                      );
                    }).toList(),
                  )
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
                     SizedBox(
                      height: 200,
                       child: ListView.builder(
                         itemCount: blocos.length,
                         scrollDirection: Axis.horizontal,
                         itemBuilder: (context, index) {
                            var bloco = blocos[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,   
                               height: MediaQuery.of(context).size.height / 7,
                                     decoration: const BoxDecoration(
                                 color: Color.fromRGBO(248,182,37,1),
                                 borderRadius: BorderRadius.all(Radius.circular(20))
                               ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Row(
                                       children: [
                                            Image.asset('assets/image.png', width: 80, height: 100,),
                                         SizedBox(
                                          width: 180,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:10),
                                            child: Column(
                                              children: [
                                                Text(bloco.title, style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),),
                                              ],
                                            ),
                                          )),
                                       ],
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.only(top: 30),
                                       child: Row(
                                         children: [
                                          Icon(Icons.pin_drop, color: Colors.red,),
                                          Text(bloco.address, style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),),
                                      
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Text(
                                            bloco.dateTime!.day.toString() != null 
                                            ? bloco.dateTime!.day.toString() + '/' + bloco.dateTime!.month.toString() : "Indisponivel", style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),),
                                        ),
                                         
                                         ],
                                       ),
                                     ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                         },
                         
                                          
                       ),
                     ),
                    ],
                  ),
              
                
                    ]
                  );
                  }
                  }
            );
                  }
              }
          );
          }
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