import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Edison Palisoc', 'Urbiztondo, Pangasinan', 'July, 2002',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/328260062_575945501081803_2091833211383891482_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHMjtHO0UlBPorFiWARPLiRY8DOBldmKFJjwM4GV2YoUk2bJvlSbKXjicVs8TJnMo0O8n05JqCzPCOu78NGRCSM&_nc_ohc=tijwpFFR5qEAX_ZHFXI&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfDhl8oqUv804eHNCSqOtv0EguvVU2nUVtJVKOzbBIa5Fg&oe=6451586F'),
    Person('Audrey Capitle', 'Urbiztondo, Pangasinan', 'April 01, 2000',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/343032434_2264339933736694_959164312419154162_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=8bfeb9&_nc_eui2=AeEUQzTWkNHqx4ZP1ihoRFKnzWNwMYKuAoHNY3Axgq4CgSVu471SWjLG60TiOleI6aczpJY8jiLcansemnuemKci&_nc_ohc=kFb5QYn78FYAX9H1mg2&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfB8609ffe5o--ZvBtBRNbrcqIUTU7L2hhr-GU70jCtofw&oe=644FEC9E'),
    Person('Winchester Bautista', 'Calobaoan, Pangasinan', 'July 06, 2002',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/339119637_5987060578014038_4837250661055971864_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_eui2=AeG5PdwczMzfo4KeVWCtXXWdEOdaODPRNA4Q51o4M9E0DmJD7IOpDRhmL7rcXNb2MWP__l-x_ber0dVokB99YhtL&_nc_ohc=pAyqdh4HAMkAX-0vkgg&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfDHBDaCQxYMZrNBuZ1x8T4NY98tUJtpBJ5ByBvOIn_WIw&oe=645020C3'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIDTERM EXAM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/qwerty.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.white,
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
