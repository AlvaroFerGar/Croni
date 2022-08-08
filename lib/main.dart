import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'cronislab.dart';
import 'cronieventform.dart';
import 'cronitypeform.dart';

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
  DateTime _selected_day = DateTime.now();
  List<Widget> _cronislabs = [];

  @override
  void initState() {
    super.initState();

    print("initState");
    //_controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    /* _events[DateTime(2022, 8, 3, 0)] = ["a", "aaa", "a"];
    _events[DateTime(2022, 8, 23, 0)] = [ "aaa", "a"];
    _events[DateTime(2022, 8, 6, 0)] = ["a"];*/
    return Scaffold(
      appBar: AppBar(
        title: Text('Croni'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text(
                  "Croni",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                accountEmail: Text(""),
                decoration: BoxDecoration(color: Colors.teal)),
            TextButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
              onPressed: () => _onPressedNewCroniType(context),
              icon: Icon(
                Icons.new_label_rounded,
                size: 16.0,
              ),
              label: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create new Crony type",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
              onPressed: () => _onClearAllEvents(context),
              icon: Icon(
                Icons.delete_forever_rounded,
                size: 16.0,
              ),
              label: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Clear all events",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
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
              print("seleccionado el dia:");
              print(date.toUtc());
              _selected_day = date;
              _onUpdateCroniSlabs(context);
            },
            builders: CalendarBuilders(
              markersBuilder: (context, date, events, holidays) {
                final lista = <Widget>[];
                if (events.isEmpty) return lista;
                //print("ejecuto markersBuilder");
                //print("hay $events.lenght() eventos en el día"+date.toString());
                lista.add(ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: events.length,
                    itemBuilder: (context, int index) {
                      if (index == null) return Container();
                      return Container(
                        margin: const EdgeInsets.only(top: 1),
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          height: 5,
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.blue,
                              backgroundBlendMode: BlendMode.darken),
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
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: _cronislabs,
                      ))))),
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
                onPressed: () => _onPressedNewCroniEvent(context),
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
      //Ojo. No se usa
      //TODO Crear una clase aparte como con los slabs
      width: 25.0,
      height: 2.5,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.rectangle,
        borderRadius: null,
      ),
    );
  }

  Future<void> _onClearAllEvents(BuildContext context) async {
    print("pressed clear");

    // set up the AlertDialog
    Widget launchButton1 = TextButton(
      child: Text("Kill them!"),
      onPressed: () {
        print("killing events");
        _events.clear();
        Navigator.pop(context);
      },
    );
    Widget launchButton2 = TextButton(
      child: Text("Oh my god, no!"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Warning!"),
      content: Text(
          "Doing this will delete\nALL your Cronis!!!.\nIs this what you intend to do?"),
      actions: [
        launchButton1,
        launchButton2,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    setState(() {});
  }


  Future<void> _onPressedNewCroniType(BuildContext context) async {
    print("_onPressedNewCroniEvent  " + _selected_day.toString());
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CroniTypeForm()));
    print(result);

    return;
  }

  Future<void> _onPressedNewCroniEvent(BuildContext context) async {
    print("_onPressedNewCroniEvent  " + _selected_day.toString());
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => CroniEventForm()));
    print(result);

    if (result == null) return;

    if (_events[_selected_day] != null) _events[_selected_day]?.add(result[1]);
    if (_events[_selected_day] == null) _events[_selected_day] = [result[1]];

    _onUpdateCroniSlabs(context);

    //_events.clear();
  }

  void _onUpdateCroniSlabs(BuildContext context) {
    _cronislabs.clear();
    print("eventos en el dia seleccionado " + _selected_day.toString());
    print(_getEventsForDay(_selected_day));
    for (String event in _getEventsForDay(_selected_day)) {
      print("eventos en el dia seleccionado");

      _cronislabs.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: CroniSlabStatelessWidget(
              bckgcolor: Colors.blueAccent,
              eventName: event,
              eventTypeName: "Surf",
              emoji: "🏄🏽")));
    }
    setState(() {});
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    print("_getEventsForDay");
    print(_events[day]);
    print("_getEventsForDay");
    return _events[day] ?? [];
  }
}
