import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lookea/providers/MainProvider.dart';
import 'package:lookea/screens/start/widgets/ReservationCard.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:provider/provider.dart';
import 'package:lookea/utils/extensions.dart';

class ReservationScreen extends StatefulWidget {

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context);

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
              child: FutureBuilder<List<dynamic>>(
                future: provider.updateReservations(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    List<dynamic> data = snapshot.data;
                    if(data.isEmpty){
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Text("Todavía no fuiste a ningun local!", style: TextStyle(color: LColors.gray4),)
                      );
                    }else{
                      return GroupedListView<dynamic, String>(
                        padding: EdgeInsets.only(bottom: 60),
                        elements: data,
                        groupBy: (element) => element['group'],
                        groupComparator: (value1, value2) {
                          int month1 = MainProvider.meses.indexOf(value1.toLowerCase());
                          int month2 = MainProvider.meses.indexOf(value2.toLowerCase());
                          return month1.compareTo(month2);
                        },
                        itemComparator: (item1, item2) => item1['model'].compareTo(item1['model']),
                        order: GroupedListOrder.DESC,
                        useStickyGroupSeparators: false,
                        groupSeparatorBuilder: (String value) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(MainProvider.meses.indexOf(value.toLowerCase()) + 1 == now.month ? "Este mes" : value.capitalize(), textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                        itemBuilder: (c, element) {
                          return ReservationCard(element["model"]);
                        },
                      );
                    }
                  }else{
                    return Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator()
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}