import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class TelaAluno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Tela Inicial Aluno'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(60),
        child: ListView(
          children: [
            Text('Bem vindo!',
                style: TextStyle(fontSize: 42, color: Colors.white)),
            SizedBox(height: 30),
            CarouselSlider(              
              options: CarouselOptions(height: 400.0),
              items: [1,2,3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor
                      ),
                      
                      child: ClipRRect(
                      child:
                        Container(
                          child: Image.asset(
                            'imagens/$i.jpg',
                            scale: 1,                      
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 30),

            ButtonTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              minWidth: 150.0,
              height: 100.0,
              hoverColor: Theme.of(context).hoverColor,
              buttonColor: Theme.of(context).buttonColor,
              child: RaisedButton(
                child: Text('Ver notas e faltas',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/verNotas',
                  );
                },
              ),
            ),
            ],
        ),
      ),
    );
  }
}
