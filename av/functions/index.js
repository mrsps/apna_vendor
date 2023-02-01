const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

var request = require("request");

// Function to inform a newly subscribed user about notifications
exports.informUser = functions.https.onCall((data, context) => {
  if (data.phone == "8826225725") {
    var headers = {
      "Cache-Control": "no-cache",
      "Content-Type": "application/x-www-form-urlencoded",
      apikey: "yfkibpb6kemqgemhwvlvzh9jizsdj3cr",
      "cache-control": "no-cache",
    };

    var dataString =
      "channel=whatsapp&source=917834811114&destination=918826225725&message=%7B%22type%22:%22text%22,%22text%22:%22Thank%20you%20for%20subscribing%20to%20whatsapp%20notifications.%20:)%5Cn%22%7D&src.name=ApnaVendor";

    var options = {
      url: "https://api.gupshup.io/sm/api/v1/msg",
      method: "POST",
      headers: headers,
      body: dataString,
    };

    function callback(error, response, body) {
      if (!error && response.statusCode == 200) {
        console.log(body);
      }
    }

    request(options, callback);
  }
});

// Function to imform all users indirectly linked to a vendor
exports.vendorOpen = functions.https.onCall(async (data, context) => {
  const vendor = await admin
    .firestore()
    .collection("appUsers")
    .doc(data.vendorId)
    .get()
    .catch((error) => {
      console.log(error);
    });

  const snapshot = await admin
    .firestore()
    .collection("leaderVendors")
    .where("vendorIds", "array-contains", data.vendorId)
    .get()
    .catch((error) => {
      console.log(error);
    });

  snapshot.docs.forEach((doc) =>
    admin
      .firestore()
      .collection("leaderConsumers")
      .doc(doc.ref.id)
      .get()
      .then((leaderConsumer) => {
        if (leaderConsumer.data() != null) {
          if (leaderConsumer.data().numbers != null) {
            leaderConsumer.data().numbers.forEach((number) => {
              if (number == "8826225725") {
                var headers = {
                  "Cache-Control": "no-cache",
                  "Content-Type": "application/x-www-form-urlencoded",
                  apikey: "yfkibpb6kemqgemhwvlvzh9jizsdj3cr",
                  "cache-control": "no-cache",
                };

                var dataString =
                  "channel=whatsapp&source=917834811114&destination=918826225725&message=%7B%22type%22:%22text%22,%22text%22:%22" +
                  vendor.data().userName +
                  "%20opened%20for%20orders%20for%20" +
                  data.days +
                  "%20days.%5CnClick%20below%20for%20creating%20your%20own%20order.%5Cnhttps://apnavendor-21d75.web.app/?leaderId=" +
                  doc.ref.id +
                  "%26vendorId=" +
                  data.vendorId +
                  "%5Cn%5Cn%22%7D&src.name=ApnaVendor";

                var options = {
                  url: "https://api.gupshup.io/sm/api/v1/msg",
                  method: "POST",
                  headers: headers,
                  body: dataString,
                };

                function callback(error, response, body) {
                  if (!error && response.statusCode == 200) {
                    console.log(body);
                  }
                }
                request(options, callback);
              }
            });
          }
        }
      })
      .catch((error) => {
        console.log(error);
      })
  );
});

// Function to inform all users linked to a leader if a fellow consumer creates an order
exports.orderCreated = functions.https.onCall((data, context) =>
  admin
    .firestore()
    .collection("leaderConsumers")
    .doc(data.leaderId)
    .get()
    .then((leaderConsumer) => {
      if (leaderConsumer.data() != null) {
        if (leaderConsumer.data().numbers != null) {
          leaderConsumer.data().numbers.forEach((number) => {
            if (number == "8826225725") {
              var headers = {
                "Cache-Control": "no-cache",
                "Content-Type": "application/x-www-form-urlencoded",
                apikey: "yfkibpb6kemqgemhwvlvzh9jizsdj3cr",
                "cache-control": "no-cache",
              };

              var dataString =
                "channel=whatsapp&source=917834811114&destination=918826225725&message=%7B%22type%22:%22text%22,%22text%22:%22" +
                data.consumerName +
                "%20placed%20an%20order%20of%20" +
                data.items +
                "%20items.%5CnClick%20below%20for%20creating%20your%20own%20order.%5Cnhttps://apnavendor-21d75.web.app/?leaderId=" +
                data.leaderId +
                "%5Cn%5Cn%22%7D&src.name=ApnaVendor";

              var options = {
                url: "https://api.gupshup.io/sm/api/v1/msg",
                method: "POST",
                headers: headers,
                body: dataString,
              };

              function callback(error, response, body) {
                if (!error && response.statusCode == 200) {
                  console.log(body);
                }
              }

              request(options, callback);
            }
          });
        }
      }
    })
    .catch((error) => {
      console.log(error);
    })
);
