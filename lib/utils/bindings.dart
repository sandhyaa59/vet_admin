import 'package:get/get.dart';
import 'package:vet_pharma/controller/admin_controller.dart';
import 'package:vet_pharma/controller/smscount_controller.dart';
import 'package:vet_pharma/controller/task_controller.dart';
import 'package:vet_pharma/controller/bill_details_controller.dart';
import 'package:vet_pharma/controller/billing_controller.dart';
import 'package:vet_pharma/controller/checkin_checkout_controller.dart';
import 'package:vet_pharma/controller/customer_controller.dart';
import 'package:vet_pharma/controller/employee_management_controller.dart';
import 'package:vet_pharma/controller/home_controller.dart';
import 'package:vet_pharma/controller/login_controller.dart';
import 'package:vet_pharma/controller/order_controller.dart';
import 'package:vet_pharma/controller/organization_controller.dart';
import 'package:vet_pharma/controller/payment_controller.dart';
import 'package:vet_pharma/controller/payment_detail_controller.dart';
import 'package:vet_pharma/controller/report_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class OrganizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizationController>(() => OrganizationController());
  }
}

class CheckInCheckOutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckInCheckOutController>(() => CheckInCheckOutController());
  }
}


class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(() => ReportController());
  }
}

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }
}

class BillingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillingController>(() => BillingController());
  }
}

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}

class MakePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}
class EmployeeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeManagementController>(
        () => EmployeeManagementController());
  }
}

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());
  }
}

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }
}

// class ReportDetailBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ReportController>(() => ReportController());
//   }
// }

class BillDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillDetailsController>(() => BillDetailsController());
  }
}

class PaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentDetailController>(() => PaymentDetailController());
  }
}


class AddTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }
}


class SmsCountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SmsNotificationCountController>(() => SmsNotificationCountController());
  }
}



class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
  }
}


