import 'package:flutter/material.dart';
import 'package:mapbox_test/screens/map.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Dark',
      'Light',
      'Streets',
      'Outdoor',
      'Satelite',
      'Satelite Street',
      'Traffic Day',
      'Traffic Night',
    ];

    final List<String> mapStyles = [
      'mapbox://styles/mapbox/dark-v10',
      'mapbox://styles/mapbox/light-v10',
      'mapbox://styles/mapbox/streets-v11',
      'mapbox://styles/mapbox/outdoors-v11',
      'mapbox://styles/mapbox/satellite-v9',
      'mapbox://styles/mapbox/satellite-streets-v11',
      'mapbox://styles/mapbox/traffic-day-v2',
      'mapbox://styles/mapbox/traffic-night-v2',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              Text(
                'Mapbox with Flutter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              GridView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(mapStyle: mapStyles[0]),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(mapStyle: mapStyles[1]),
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(mapStyle: mapStyles[2]),
                          ),
                        );
                      }else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(mapStyle: mapStyles[3]),
                          ),
                        );
                      }else if (index == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(mapStyle: mapStyles[4]),
                          ),
                        );
                      } else if (index == 5) {   
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(mapStyle: mapStyles[5]),
                          ),
                        );
                      } else if (index == 6) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(mapStyle: mapStyles[6]),
                          ),
                        );
                      } else if (index == 7) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapScreen(mapStyle: mapStyles[7]),
                          ),
                        );
                      } 
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          items[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
