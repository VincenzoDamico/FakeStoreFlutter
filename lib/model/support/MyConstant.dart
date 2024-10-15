class MyConstant {
  static final mobileWidth = 600;

//padding
  static const pmd = 8.0;
  static const rmd = 20.0;

//BorderRadius SO I BORDI ARRROTONDATI
  static final bAm = 16.0;

//SHADOW
  static final bR = 5.0;
  static final sR = 2.0;



//filterLayout
  static final wfmax = 250.0;

//productCard
  static final wmax = 320.0;
  static final hmax = 450.0;

  //img
  static final  himg = 250.0;

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";
  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:9090";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

// requests
  static final String REQUEST_ALL_PRODUCTS = "ApiProduct/productAll";
  static final String REQUEST_CATEGORY_PRODUCTS= "ApiProduct/productCategory";
  static final String REQUEST_CATEGORY_BRANDS= "/ApiBrand/brandCategory";
  static final String REQUEST_PRODUCTS_CATEGORY_BRANDS= "ApiProduct/productCategoryBrand";
  static final String REQUEST_PURCHASE="ApiPurchase";
  static final String REQUEST_ADD_USER="ApiUsers";

  // authentication
  static final String REALM = "fake-store";
  static final String CLIENT_ID = "api-store";
  static final String CLIENT_SECRET = "EPIZUwiZGVsAYMiPx7omEIZLVP2sqTNe";
  static final String REQUEST_LOGIN = "realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "realms/" + REALM + "/protocol/openid-connect/logout";


}