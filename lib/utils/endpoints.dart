class EndPoints {
  static const String BASEURL = "http://localhost:8080/v1/api";
  static const String LOGIN = "$BASEURL/admin/login";
  //report..

  static const String REPORT_LIST = "$BASEURL/report/list";
  static const String REPORT_EMPLOYEE = "$BASEURL/report/list/";

  static const String CHECKINOUTLIST = "$BASEURL/check-in-out";

  static const String ORDERLIST = "$BASEURL/order/list";
  static const String ORDER_CANCEL = "$BASEURL/order/cancel/";

  //bill
  static const String BILL_CANCEL = "$BASEURL/admin/bill/cancel/";
  static const String BILL_LIST = "$BASEURL/admin/bill";
  static const String BILL_SAVE = "$BASEURL/admin/bill";
  static const String BILL_DETAILS = "$BASEURL/admin/bill/details";

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

  //customer...
  static const String CUSTOMER_LIST = "$BASEURL/admin/customer/list";
  static const String CUSTOMER_ACTIVATE = "$BASEURL/admin/customer/activate/";
  static const String CUSTOMER_DEACTIVATE ="$BASEURL/admin/customer/deactivate/";
  static const String CUSTOMER_DDELETE = "$BASEURL/admin/customer/delete/";
  static const String CUSTOMER_ADD = "$BASEURL/admin/customer/save";
  static const String CUSTOMER_UPDATE = "$BASEURL/admin/customer/update";

  //payment...
  static const String PAYMENT_LIST = "$BASEURL/admin/payment";

  //organization..
  static const String ORGANIZATION_LIST = "$BASEURL/admin/organization/1";

//cancel o
}
