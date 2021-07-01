/*class Commande {

  @override
  String toString() {
    return 'Commande{documentId:$documentId, adresLivraison: $adresLivraison, autreDetail: $autreDetail, commune: $commune, dateLivraison: $dateLivraison, nbrePoul: $nbrePoul, nomPrenom: $nomPrenom, periode: $periode, quatiers: $quatiers, tel: $tel, statutLivraison: $statutLivraison, cmdId:$cmdId,}';
  }

}*/
import 'package:cloud_firestore/cloud_firestore.dart';

class Commande {
  String adresLivraison;
  String autreDetail;
  String commune;
  String dateLivraison;
  String nbrePoul;
  String nomPrenom;
  String periode;
  String quatiers;
  String tel;
  String cmdId;
  bool statutLivraison;
  String documentId;
  final DocumentReference reference;
  Commande(this.reference,
      {this.documentId,
        this.adresLivraison,
        this.autreDetail,
        this.commune,
        this.dateLivraison,
        this.nbrePoul,
        this.nomPrenom,
        this.periode,
        this.quatiers,
        this.statutLivraison,
        this.cmdId,
        this.tel});
  Commande.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nbrePoul'] != null),
        assert(map['nomPrenom'] != null),
        assert(map['tel'] != null),
        nbrePoul = map['nbrePoul'],
        nomPrenom = map['nomPrenom'],
        tel = map['tel'];

  Commande.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Commande<$nbrePoul:$nomPrenom:$tel>";
}