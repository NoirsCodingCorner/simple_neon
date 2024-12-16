
// Assuming these custom widgets are defined elsewhere in your project
// import 'neon_widgets.dart'; // Replace with your actual import path

import 'package:flutter/material.dart';

import '../simple_neon.dart';

class AllWidgets extends StatefulWidget {
  const AllWidgets({super.key});

  @override
  State<AllWidgets> createState() => _AllWidgetsState();
}

class _AllWidgetsState extends State<AllWidgets> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PulsingStarsBackground(
            spawnDuration: const Duration(milliseconds: 50),
            maxStars: 50,
          ),
          Center(
            child: Container(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("NeonText",style: TextStyle(color: Colors.white),), NeonText(text: "NeonText",)],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("NeonButton",style: TextStyle(color: Colors.white),), NeonButton(icon: Icons.abc, onPressed: () {},size: 60,neonColor: Colors.pink,)],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("NeonCard",style: TextStyle(color: Colors.white),), NeonCard(children: [Text("NeonCard",style: TextStyle(color: Colors.white))], neonColor: Colors.greenAccent)],
                    ),
                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("NeonContainer",style: TextStyle(color: Colors.white),), NeonContainer(neonColor: Colors.purpleAccent,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("NeonContainer",style: TextStyle(color: Colors.white)),
                      ),)],
                    ),
                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("NeonSlider",style: TextStyle(color: Colors.white),), SizedBox(width: 100,height: 20,child: NeonSlider(segments: 5,neonColor: Colors.blueAccent, value: 0.5, onChanged: (double value) {  },))],
                    ),
                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("NeonProgressBar",style: TextStyle(color: Colors.white),), SizedBox(width: 100,height: 20,child: NeonProgressBar(progress: 0.5,neonColor: Colors.red,))],
                    ),
                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("NeonTextField",style: TextStyle(color: Colors.white),), SizedBox(width: 100,height: 20,child: NeonTextField(neonColor: Colors.orangeAccent, textValue: ValueNotifier("ValueNotifier"),))],
                    ),
                  ],
                ),
              )
              ,
            ),),
        ],
      ),
    );
  }
}
