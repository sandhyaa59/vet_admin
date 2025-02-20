// ignore_for_file: constant_identifier_names
// demo@gmail.com
// Demo@12
class EndPoints {
  static const String LOCAL = "http://192.168.18.21:8080";
  static const String PROD = "https://backend.purwanchalagro.trackyoe.com/";
  static const String appNameLocals = "";
  static const String appNameServer = "DemoTrackyoe";
  static const String BASEURL = "$PROD$appNameServer/v1/api";
  static const String LOGIN = "$BASEURL/admin/login";
  //purwanchalagro  nationalvet

  static const String REPORT_LIST = "$BASEURL/report/list";
  static const String REPORT_EMPLOYEE = "$BASEURL/report/list/";

  static const String CHECKINOUTLIST = "$BASEURL/check-in-out";

  static const String ORDERLIST = "$BASEURL/order/list";
  static const String ORDER_CANCEL = "$BASEURL/order/cancel/";
  static const String REPORT_STAT = "$BASEURL/order/summary";

  //bill
  static const String BILL_CANCEL = "$BASEURL/admin/bill/cancel/";
  static const String BILL_LIST = "$BASEURL/admin/bill";
  static const String BILL_SAVE = "$BASEURL/admin/bill";
  static const String BILL_DETAILS = "$BASEURL/admin/bill/details";
  static const String BILL_SEARCH = "$BASEURL/admin/bill/search/";

  //employee...
  static const String EMPLOYEEMANAGEMENT_LIST =
      "$BASEURL/employee/list-employee";
  static const String EMPLOYEEMANAGEMENT_ACTIVATE =
      "$BASEURL/employee/activate/";
  static const String EMPLOYEEMANAGEMENT_DEACTIVATE =
      "$BASEURL/employee/deactivate/";
  static const String EMPLOYEEMANAGEMENT_DELETE = "$BASEURL/employee/delete/";
  static const String EMPLOYEEMANAGEMENT_SAVE = "$BASEURL/employee/save";
  static const String EMPLOYEEMANAGEMENT_UPDATE = "$BASEURL/employee/update";
  static const String EMPLOYEEMANAGEMENT_ACTIVE_LIST =
      "$BASEURL/employee/active";
  static const String EMPLOYEE_MAP = "$BASEURL/location";

  //customer...
  static const String CUSTOMER_LIST = "$BASEURL/admin/customer/list";
  static const String CUSTOMER_ACTIVATE = "$BASEURL/admin/customer/activate/";
  static const String CUSTOMER_DEACTIVATE =
      "$BASEURL/admin/customer/deactivate/";
  static const String CUSTOMER_DDELETE = "$BASEURL/admin/customer/delete/";
  static const String CUSTOMER_ADD = "$BASEURL/admin/customer/save";
  static const String CUSTOMER_UPDATE = "$BASEURL/admin/customer/update";
  static const String CUSTOMER_SEARCH = "$BASEURL/admin/customer/search/";
 static const String CUSTOMER_DOWNLOAD = "$BASEURL/admin/customer/download/excel";
  static const String CUSTOMER_UPLOAD = "$BASEURL/admin/customer/upload/excel";
  //payment...
  static const String PAYMENT_LIST = "$BASEURL/admin/payment";

  //organization..
  static const String ORGANIZATION_LIST = "$BASEURL/admin/organization";
  static const String ORGANIZATION =
      "http://192.168.18.8:8080/v1/api/admin/organization";

//task..
  static const String SAVE_TASK = "$BASEURL/task";
  static const String TASK_LIST = "$BASEURL/task";
  static const String TASK_UPDATE = "$BASEURL/task";

  static const String SMS = "$BASEURL/admin/sms";

  static const String ListAdmin = "$BASEURL/admin/list-admin";
  static const String AdminAdd = "$BASEURL/admin/save";
  static const String AdminDeactivate = "$BASEURL/admin/deactivate/";
  static const String AdminActivate = "$BASEURL/admin/activate/";
  static const String AdminDelete = "$BASEURL/admin/delete/";
  static const String ViewAdmin = "$BASEURL/admin/detail/";
  static const String UpdateAdmin = "$BASEURL/admin/update";
  static const String AdminSearch = "$BASEURL/admin/search/";

  static const String AddCategory = "$BASEURL/admin/category/add";
  static const String listCategory = "$BASEURL/admin/category/list";
  static const String CategoryOnly = "$BASEURL/admin/category/only";
  static const String Category_Update= "$BASEURL/admin/category/update";
   static const String Category_Deactivate= "$BASEURL/admin/category/deactivate/";
    static const String Category_Activate= "$BASEURL/admin/category/reactivate/";


  static const String Product = "$BASEURL/admin/products/list";
  static const String Product_Add = "$BASEURL/admin/products/add";
   static const String Product_update = "$BASEURL/admin/products/update";
  static const String product_deactivate = "$BASEURL/admin/products/deactivate/";
   static const String product_activate = "$BASEURL/admin/products/reactivate/";

  static const String Discount = "$BASEURL/admin/discounts";
   static const String Discount_Update = "$BASEURL/admin/discounts/update/";
}
