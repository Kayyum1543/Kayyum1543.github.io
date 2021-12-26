
function paymentProcess(uid) {



    var options = {
        "key": "rzp_test_amx1VyubRPCMo2", // Enter the Key ID generated from the Dashboard
        "amount": 320*100, // Amount is in currency subunits. Default currency is INR. Hence, 50000 means 50000 paise or ₹500.
        "currency": "INR",
        "name": "Phonescore",
        "description": "Phonescore pro version",
        "image": "PhoneScore_logo.png",// Replace this with the order_id created using Orders API (https://razorpay.com/docs/api/orders).
     "handler": function (response){
        alert(response.razorpay_payment_id);
        firebase
        .firestore()
        .collection("buyer")
        .doc('user')
        .set({
          'id': uid,
          'paymentid':response.razorpay_payment_id,
          'paymentstatus':'success'
        })
        .then(() => {
          console.log("Document created.payment successful");
        });
            //savetoDB(response,uid);
           return 'true';
           // $('#myModal').modal();
        },
        "prefill": {
            "name": "Kayyum Subhedar",
            "email": "kayyumsubhedar1@gmail.com",
            "contact": "8788500287"
        },
        "notes": {
            "address": "note value"
        },
        "theme": {
            "color": "#9932CC"
        }
    };
    var propay = new Razorpay(options);
    propay.on('payment.failed', function (response){
      
        
        
       
        alert(response.error.code);
        alert(response.error.description);
        alert(response.error.source);
        alert(response.error.step);
        alert(response.error.reason);
        alert(response.error.metadata.order_id);
        alert(response.error.metadata.payment_id);
        return false;
        firebase
        .firestore()
        .collection("buyer")
        .doc('user')
        .set({
          'id': uid,
          'pamentid':response.razorpay_payment_id,
          'pamentstatus':'Unsuccesful'
        })
        .then(() => {
          console.log("Document created, payment unsuccesful");
        });

       
});
    propay.open();
}


function savetoDB(response,uid) {
    console.log(response)
    //firebase.initializeApp(firebaseConfig);
   // var payRef = firebase.database().ref('payment');
   //const db = firebase.firestore();
   //print(response.Paymentid);
  // print(response.description);
  firebase
   .firestore()
   .collection("buyer")
   .doc(uid)
   .set({
     'Paymentid': uid,
   })
   .then(() => {
     console.log("Document created");
   });
    //payRef.child('123456789').set({
   // payment_id : response.razorpay_payment_id
   // })*/
  // paymentComplete();
}
