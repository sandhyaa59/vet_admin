import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vet_pharma/screens/admin.dart';
import 'package:vet_pharma/screens/bill_details_screen.dart';
import 'package:vet_pharma/screens/billing.dart';
import 'package:vet_pharma/screens/checkin-checkout.dart';
import 'package:vet_pharma/screens/customer.dart';
import 'package:vet_pharma/screens/employee_management.dart';
import 'package:vet_pharma/screens/homescreen.dart';
import 'package:vet_pharma/screens/login_screen.dart';
import 'package:vet_pharma/screens/make_payment.dart';
import 'package:vet_pharma/screens/order.dart';
import 'package:vet_pharma/screens/order_details_screen.dart';
import 'package:vet_pharma/screens/organization_screen.dart';
import 'package:vet_pharma/screens/payment.dart';
import 'package:vet_pharma/screens/payment_details_screen.dart';
import 'package:vet_pharma/screens/report_screen.dart';
import 'package:vet_pharma/screens/reportdetail.dart';
import 'package:vet_pharma/screens/sms_notification.dart';
import 'package:vet_pharma/screens/task.dart';
import 'package:vet_pharma/utils/bindings.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route == Routes.HOME ||
        route == Routes.CHECKINCHECKOUT ||
        route == Routes.REPORT ||
        route == Routes.ORDER ||
        route == Routes.BILLING ||
        route == Routes.PAYMENT ||
        route == Routes.EMPLOYEE_MANAGEMENT ||
        route == Routes.CUSTOMERLIST ||
        route == Routes.REPORT_DETAILS ||
        route == Routes.ORDER_DETAILS ||
        route == Routes.BILL_DETAILS ||
        route == Routes.PAYMENT_DETAILS
        ) {
      if (!isAuthenticated()) {
        return const RouteSettings(name: Routes.LOGIN);
      }
    }
    return null;
  }

  bool isAuthenticated() {
    var token = StorageUtil.getValue("token");
    return token != null;
  }
}

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: Routes.LOGIN, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(name: Routes.HOME, page: () => HomeScreen(), bindings: [
      HomeBinding(),
      OrganizationBinding(),
    ],middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.CHECKINCHECKOUT,
        page: () => CheckInCheckOutScreen(),
        binding: CheckInCheckOutBinding()),
    GetPage(
        name: Routes.REPORT,
        page: () => ReportScreen(),
        binding: ReportBinding()),
    GetPage(
        name: Routes.ORDER,
        page: () => OrderScreen(),
        bindings: [OrderBinding(), OrganizationBinding()]),
    GetPage(
        name: Routes.BILLING,
        page: () => BillingScreen(),
        bindings: [BillingBinding(), OrganizationBinding()]),
    GetPage(
        name: Routes.PAYMENT,
        page: () => PaymentScreen(),
        bindings: [PaymentBinding(), OrganizationBinding()]),
         GetPage(
        name: Routes.MAKE_PAYMENT,
        page: () => MakePayment(),
        bindings: [PaymentBinding()]),
    GetPage(
        name: Routes.EMPLOYEE_MANAGEMENT,
        page: () => EmployeeManagementScreen(),
        binding: EmployeeManagementBinding()),
    GetPage(
        name: Routes.CUSTOMERLIST,
        page: () => CustomerScreen(),
        binding: CustomerBinding()),
    GetPage(
        name: Routes.REPORT_DETAILS,
        page: () => ReportDetail(),
        binding: ReportBinding()),
    GetPage(
        name: Routes.ORDER_DETAILS,
        page: () => OrderDetailsScreen(),
        binding: OrderDetailBinding()),
    GetPage(
        name: Routes.BILL_DETAILS,
        page: () => BillDetailsScreen(),
        binding: BillDetailsBinding()),
    GetPage(
        name: Routes.PAYMENT_DETAILS,
        page: () => PaymentDetailsScreen(),
        bindings: [PaymentDetailBinding(),PaymentBinding()]),

         GetPage(
        name: Routes.ADD_TASK,
        page: () => Task(),
        binding: AddTaskBinding()),

         GetPage(
        name: Routes.ORGANIZATION ,
        page: () => OrganozationScreen(),
        binding: OrganizationBinding()),
          GetPage(
        name: Routes.SMSNOTIFICATION_COUNT ,
        page: () => SmsNoificationCount(),
        binding: SmsCountBinding()),
        GetPage(
        name: Routes.ADMIN ,
        page: () => AdminList(),
        binding: AdminBinding()),
    GetPage(
      name: Routes.INITIAL_LOAD,
      page: () => FutureBuilder(
        future: Future(() async {
          var token = await StorageUtil.getValue("token");
          if (token != null) {
            return "perfect";
          } else {
            return "login";
          }
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              Future.delayed(
                Duration.zero,
                () {
                  if (snapshot.data == "perfect") {
                    return Get.offAllNamed(Routes.HOME);
                  } else {
                    return Get.offAllNamed(Routes.LOGIN);
                  }
                },
              );
            }
          }
          return Container();
        },
      ),
      middlewares: [AuthMiddleware()],
    ),
  ];
}

class Routes {
  static const String INITIAL_LOAD = "/initial-load";

  static const String HOME = "/home";
  static const String LOGIN = "/login";
  static const String CHECKINCHECKOUT = "/checkin-checkout";
  static const String EMPLOYEE = "/employee";
  static const String REPORT = "/report";
  static const String ORDER = "/order";
  static const String BILLING = "/billing";
  static const String PAYMENT = "/payment";
  static const String EMPLOYEE_MANAGEMENT = "/employee-management";
  static const String EMPLOYEE_UPDATE = "/employee-update";

  static const String CUSTOMERLIST = "/customer-list";
  static const String CUSTOMER_UPDATE = "/customer-update";

  static const String REPORT_DETAILS = "/report-detail";
  static const String ORDER_DETAILS = "/order-details";
  static const String BILL_DETAILS = "/bill-details";
  static const String PAYMENT_DETAILS = "/payment-details";
  static const String MAKE_PAYMENT = "/make-payment";

    static const String ADD_TASK = "/add-task";
    static const String ORGANIZATION = "/organization";
    static const String SMSNOTIFICATION_COUNT = "/sms-notification-count";


    static const String ADMIN = "/admin";

}
