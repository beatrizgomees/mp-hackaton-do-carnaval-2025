import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
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
                          // Perform the search here
                      },
                    ),
                     border: InputBorder.none, // Remove a borda
                    enabledBorder: InputBorder.none, // Remove a borda quando inativo
                    focusedBorder: InputBorder.none, // Remove a borda quando focado
                  ),
                ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}