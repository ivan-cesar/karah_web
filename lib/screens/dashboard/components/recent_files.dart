import 'package:admin/models/Commande.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key key,
  }) : super(key: key);

  /* Widget build(BuildContext context) {
    Commande commande = new Commande();
    List<Commande> mesCommande = [];
    if (snapshot != null && snapshot.data != null)
      snapshot.data.documents.forEach((element) {
        Commande maCommande = Commande(
          adresLivraison: element['adresLivraison'],
          autreDetail: element['autreDetail'],
          commune: element['commune'],
          dateLivraison: DateFormat('dd-MM-yyyy')
              .format(element['dateLivraison'].toDate()),
          nbrePoul: element['nbrePoul'].toString(),
          nomPrenom: element['nomPrenom'],
          periode: element['periode'],
          documentId: element['documentId'],
          quatiers: element['quartiers'],
          statutLivraison: element['statutLivraison'],
          tel: element['tel'].toString(),
        );
        mesCommande.add(maCommande);
      });
  }
    final products = Provider.of<List<Commande>>(context);
    return Scaffold(
        body: Container(
        child: DataTable(
        columns: [
        DataColumn(label: Text('Id')),
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Price')),
    ],
    rows: List<DataRow>.generate(
    mesCommande.length,
    (index) => DataRow(cells: [
    DataCell(Text(mesCommande[index]. )),
    DataCell(Text(products[index].name)),
    DataCell(Text(products[index].price.toString())),
    ])),
    ),
    ),


    Stream<List<Commande>> getCommande(){
    return _db.collection('commande').snapshots().map((snapshot) => snapshot.docs.map((document) => Commande.fromFirestore(document.data())).toList());
    };

*/

  Widget build(BuildContext context) {
    var nbr;
    return /*Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Commandes Récentes",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("Nom "),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Size"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );*/
      Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          "Commandes Récentes",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('commande').snapshots(),
          builder: (context, snapshot) {
            var nbr;
            if (!snapshot.hasData) return LinearProgressIndicator();

            return SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: [
                    DataColumn(label:Text('Nom')),
                  DataColumn(label: Text('poulets')),
                  DataColumn(label: Text('téléphone')),
                  DataColumn(label: Text('Statut')),

                ],
                rows: _buildList(context, snapshot.data.docs),
              ),
            );
          },
        ),
        ],
      ));
  }

  List<DataRow> _buildList(BuildContext context,
      List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Commande.fromSnapshot(data);
    String _selectedValue;
    List<String> listOfValue = ['Livré', 'Non livré',];
    return DataRow(
        selected:true,
        cells:
        [
          DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 1,child:Text(record.nomPrenom) ,)),
          DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 1,child:Text(record.nbrePoul.toString()))),
          DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 1,child: Text(record.tel),)),
          DataCell(Container(width: (MediaQuery.of(context).size.width / 10) * 1,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(right: 0.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  isDense: true),
              value: _selectedValue,
              hint: Text('Choisir statut',),

              isExpanded: false,
              onChanged: (value) {
                _selectedValue = value;
                /*setState(() {
              _selectedValue = value;
            });*/
              },
              onSaved: (value) {
                _selectedValue = value;
                /*setState(() {
              _selectedValue = value;
            });*/
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return "Ne peut pas être vide";
                } else {
                  return null;
                }
              },
              items: listOfValue
                  .map((String val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(
                    val,
                  ),
                );
              }).toList(),
            ),
          ) ),
        ]);
  }
}
/*DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date)),
      DataCell(Text(fileInfo.size)),
    ],
  );
}*/
