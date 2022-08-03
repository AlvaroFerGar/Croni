import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'cronislab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 123, 103, 1),
      ),
      home: HomeCalendarPage(),
    );
  }
}

class HomeCalendarPage extends StatefulWidget {
  @override
  _HomeCalendarPageState createState() => _HomeCalendarPageState();
}

class _HomeCalendarPageState extends State<HomeCalendarPage> {
  CalendarController _controller = CalendarController();

  Map<DateTime, List<dynamic>> _events = {};
  List<dynamic> _selectedEvents = [];

  @override
  void initState() {
    super.initState();

    print("ejecuto");
    //_controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    _events[DateTime(2022, 8, 3, 0)] = ["a", "aaa", "a"];
    _events[DateTime(2022, 8, 23, 0)] = [ "aaa", "a"];
    _events[DateTime(2022, 8, 6, 0)] = ["a"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Croni'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            events: _events,
            initialCalendarFormat: CalendarFormat.month,
            calendarStyle: CalendarStyle(
                canEventMarkersOverflow: false,
                todayColor: Colors.transparent,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.black)),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(22.0),
              ),
              formatButtonTextStyle: TextStyle(color: Colors.white),
              formatButtonShowsNext: false,
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (date, events, _) {
              print(date.toUtc());
            },
            builders: CalendarBuilders(
              markersBuilder: (context, date, events, holidays) {
                final lista = <Widget>[];
                if (events.isEmpty) return lista;
                print("ejecuto---");
                print("hay $events.lenght() eventos");
                lista.add(ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: events.length,
                    itemBuilder: (context, int index) {
                      if(index==null)
                        return Container();
                      return Container(
                        margin: const EdgeInsets.only(top: 1),
                        padding: const EdgeInsets.all(1),
                        child: Container(
                           height: 5,
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle, color: Colors.blue),
                        ),
                      );
                    }));
                return lista;
                /*if (events.isNotEmpty) {
                  lista.add(
                    Positioned(
                      bottom: 1,
                      child: _buildEventsMarker(date, events),
                    ),
                  );
                }
                return lista;*/
              },
              selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black),
                  )),
            ),
            calendarController: _controller,
          ),
          Expanded(
              child: Container(
                  color: Colors.transparent,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: CroniSlabStatelessWidget(
                                bckgcolor: Colors.blueAccent,
                                eventName: "Bañito",
                                eventTypeName: "Surf",
                                emoji: "🏄🏽")),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: CroniSlabStatelessWidget(
                                bckgcolor: Colors.pink,
                                eventName: "Rango",
                                eventTypeName: "Pelis",
                                emoji: "📽")),
                      ]))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.grey,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text(
                  "+",
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
                onPressed: null,
              ),
            ),
          ),
          //Container(height: 10, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Container(
      width: 25.0,
      height: 2.5,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.rectangle,
        borderRadius: null,
      ),
    );
  }
}
