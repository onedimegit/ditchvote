ditchvote(String id) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('dchats')
        .doc('vote')
        .set({'vote': 0, 'castedby': FieldValue.arrayUnion([])});

    Future<QuerySnapshot> rid = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('dchats')
        .where('vote')
        .get();

    rid.then((value) {
      value.docs.forEach((element) {
        voter = element['castedby'];
        vote = element['vote'];
      });
    }).then((value) {
      print(value);
      print('voter $voter');
      print('vote $vote');
    });

    if (!voter.contains(myid)) {
      print('You have casted');
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('dchats')
          .doc('vote')
          .update({
        'vote': FieldValue.increment(1),
        'castedby': FieldValue.arrayUnion([myid])
      });
    } else if (voter == null || !voter.contains(myid)) {
      print('you didn\'t cast yet');
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('dchats')
          .doc('vote')
          .update({
        'vote': 1,
        'castedby': FieldValue.arrayUnion([myid])
      });
    } else {
      return null;
    }
}
