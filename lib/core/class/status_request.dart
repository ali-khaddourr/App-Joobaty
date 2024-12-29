enum StatusRequest { // status server
  loading,
  success, /// state 200
  failure,
  serverFailure, // problem in server ======
  offlineFailure, // no internet
  none
}
