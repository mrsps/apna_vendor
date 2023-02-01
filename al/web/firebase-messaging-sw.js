importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCvcDacMi00b2pvpQS7xlLeq2GXDec5ubo",
  authDomain: "apnavendor-21d75.firebaseapp.com",
  projectId: "apnavendor-21d75",
  storageBucket: "apnavendor-21d75.appspot.com",
  messagingSenderId: "490189706887",
  appId: "1:490189706887:web:bd17f6b18e8757f8d98a22",
  measurementId: "G-LM1VJRHXX8"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});