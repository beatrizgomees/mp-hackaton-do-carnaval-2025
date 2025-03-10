import 'package:carnaval_no_bolso_app/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlocosList extends StatefulWidget {
  @override
  _BlocosListState createState() => _BlocosListState();
}

class _BlocosListState extends State<BlocosList> {
  double containerHeight = 500.0; // Altura inicial

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification) {
          setState(() {
            containerHeight = (containerHeight - scrollNotification.metrics.pixels).clamp(500.0, 600.0);
          });
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.map),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Blocos Próximos de você",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: Provider.of<HomeViewModel>(context, listen: false).fetchAllBlocos(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }
                final blocos = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: containerHeight, // Altura dinâmica
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: blocos.length,
                      itemBuilder: (context, index) {
                        var bloco = blocos[index];
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      bloco.title,
                                      style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          bloco.address,
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                        Text(bloco.dateTime != null
                                            ? '${bloco.dateTime!.hour}:${bloco.dateTime!.minute}'
                                            : 'Horário Indefinido'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
