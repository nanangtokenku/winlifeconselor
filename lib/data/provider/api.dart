class Api {
  static const String _baseUrl = 'http://web-backend.winlife.id/';
  static const String API_KEY = 'EBD19D22637AFD0BC40DE7B0A8F44E09';

  static const String IMAGE_KATEGORI_URL = _baseUrl + "uploads/v13nr_kategori/";

  static const String _API = _baseUrl + 'api/';
  static const String IMAGE_KONSELOR_URL =
      _baseUrl + "uploads/konselor_detail/";

//auth
  static const String LOGIN = _API + 'user/login';
  static const String REGISTER = _API + 'register_konselor/add';

  static const String DURATION = _API + 'duration_service/all';
  static const String KATEGORI = _API + 'v13nr_kategori/all';
  static const String KONSELOR = _API + 'register_konselor/all';
  static const String KONSELORDETAIL = _API + 'register_konselor/detail';
  static const String KONSELORBERKAS = _API + 'konselor_detail/add';

  //order
  static const String ORDERDETAILALL = _API + '/order_detail/all';
  static const String ORDERDETAIL = _API + '/order_detail/detail';
  static const String ORDERDETAILSUMMARY = _API + '/summary/add';
}
