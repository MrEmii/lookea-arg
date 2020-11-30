import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lookea/screens/start/widgets/ReservationCard.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/text_input.dart';


class ReservationScreen extends StatefulWidget {

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {

  final dataSet = [
    {'name': 'John', 'group': 'Noviembre'},
    {'name': 'Will', 'group': 'Marzo'},
    {'name': 'Beth', 'group': 'Noviembre'},
    {'name': 'Miranda', 'group': 'Noviembre'},
    {'name': 'Mike', 'group': 'Septiembre'},
    {'name': 'Danny', 'group': 'Septiembre'},
    {'name': 'Mike', 'group': 'Septiembre'},
    {'name': 'Danny', 'group': 'Septiembre'},
    {'name': 'Mike', 'group': 'Septiembre'},
    {'name': 'Danny', 'group': 'Septiembre'},
  ];

  List<String> meses = ["enero","febrero","marzo","abril","mayo","junio","julio","agosto","septiembre","octubre","noviembre","diciembre"];

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Tus Reservas", textAlign: TextAlign.left, style: TextStyle(color: LColors.black9, fontSize: 24, fontWeight: FontWeight.w600),),
            TextInputComponent(
              placeholder: "Busca por nombre",
              width: MediaQuery.of(context).size.width,
              suffixIcon: Icon(LIcons.search, size: 18, color: LColors.gray4,),
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 20),
              onSubmit: (submit) {
                print(submit);
              },
              validator: (mail) {
                return null;
              },
            ),
            Expanded(
              child: GroupedListView<dynamic, String>(
                padding: EdgeInsets.only(bottom: 60),
                elements: dataSet,
                groupBy: (element) => element['group'],
                groupComparator: (value1, value2) {
                  int month1 = meses.indexOf(value1.toLowerCase());
                  int month2 = meses.indexOf(value2.toLowerCase());
                  return month1.compareTo(month2);
                },
                itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: false,
                groupSeparatorBuilder: (String value) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    meses.indexOf(value.toLowerCase()) + 1 == now.month ? "Este mes" : value,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                itemBuilder: (c, element) {
                  return ReservationCard();
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}