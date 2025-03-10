import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vet_pharma/controller/bill_details_controller.dart';
import 'package:vet_pharma/controller/organization_controller.dart';
import 'package:vet_pharma/model/bill_details_response.dart';

final controller = Get.find<BillDetailsController>();

final controllers = Get.find<OrganizationController>();

getPdfNormalTextRow(
    String title, String content, String title2, String content2) {
  return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text('$title $content', style: pw.TextStyle()),
        pw.Text('$title2 $content2', style: pw.TextStyle())
      ]);
}

getPdSingleTextRow(String title, String content) {
  return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text('$title:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(content, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
      ]);
}

Future<void> generateAndPrintBill(
  BillDetailsResponse billDetails,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Center(
              child: pw.Text(
                controllers.organizationDetail.value.name ?? "",
                style: pw.TextStyle(
                    fontSize: 20.0, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Text(
                'Email:${controllers.organizationDetail.value.email},Phone: ${controllers.organizationDetail.value.phoneNo}',
                style: pw.TextStyle()),
            pw.Text(
                'Pan No: ${controllers.organizationDetail.value.panNo},Address ${controllers.organizationDetail.value.address}',
                style: pw.TextStyle()),
            pw.SizedBox(height: 10.0),
            pw.Center(
              child: pw.Text(
                'Estimate',
                style: pw.TextStyle(
                    fontSize: 20.0, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 10.0),
            getPdfNormalTextRow(
                'Customer: ',
                controller.billDetails.value.customerName ?? '',
                "Contact:",
                controller.billDetails.value.customerMobileNo ?? ""),
            getPdfNormalTextRow(
                'Shop Name: ',
                controller.billDetails.value.orderResponse?.shopName ?? '',
                'Email:',
                controller.billDetails.value.customerEmail ?? ''),
            // getPdSingleTextRow('Customer Pan:',
            //     controller.billDetails.value.orderResponse?.customerPan ?? ''),
            pw.SizedBox(height: 10),
            // pw.Text("Order Details",
            //     style:
            //         pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            getPdfNormalTextRow(
                "Order Status:",
                controller.billDetails.value.orderResponse?.status ?? '',
                "Order Date:",
                controller.billDetails.value.orderResponse?.addedDateTime ??
                    ''),

            pw.SizedBox(height: 10),
            // pw.Text("Employee Details",
            //     style:
            //         pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            // pw.Text(
            //     "Employee Name: ${controller.billDetails.value.orderResponse?.employeeName ?? ''}"),
            // pw.SizedBox(height: 10),
            // pw.Text("Bill Details",
            //     style:
            //         pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            getPdfNormalTextRow(
                "Bill No:",
                controller.billDetails.value.billNo.toString(),
                "Bill Date:",
                controller.billDetails.value.createdAt ?? ''),

            if (controller.billDetails.value.isVoid == true)
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                decoration: const pw.BoxDecoration(color: PdfColors.red),
                child: pw.Text("Void",
                    style: pw.TextStyle(
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold)),
              ),
            pw.SizedBox(height: 10),
            pw.Text("Ordered Items",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(1),
                2: const pw.FlexColumnWidth(1),
                3: const pw.FlexColumnWidth(1),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                      border: pw.Border(
                          bottom: pw.BorderSide(color: PdfColors.black))),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text("Title",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text("Quantity",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text("Unit",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text("Price",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                ...controller.billDetails.value.orderResponse?.responses!
                        .map((item) => pw.TableRow(
                              children: [
                                pw.Padding(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(item.title ?? ""),
                                ),
                                pw.Padding(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(item.quantity.toString()),
                                ),
                                pw.Padding(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(item.unit ?? ""),
                                ),
                                pw.Padding(
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(item.price.toString()),
                                ),
                              ],
                            )) ??
                    [],
              ],
            ),
            pw.SizedBox(height: 10),
            pw.SizedBox(height: 10),
            // if ((controller.billDetails.value.orderResponse?.description ?? "")
            //     .isNotEmpty)
            //   pw.Text(
            //       "Description: ${controller.billDetails.value.orderResponse?.description}",
            //       style: const pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 10),
            // pw.Text("Summary",
            //     style:
            //         pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            getPdSingleTextRow(
                "Sub Total:", controller.billDetails.value.subTotal.toString()),
            getPdSingleTextRow(
                "Discount:", controller.billDetails.value.discounts.toString()),
            getPdSingleTextRow(
                "Tax:", controller.billDetails.value.tax.toString()),
            getPdSingleTextRow(
                "Due:", controller.billDetails.value.dueAmount.toString()),
            getPdSingleTextRow(
                "Received:", controller.billDetails.value.received.toString()),
            getPdSingleTextRow(
              "Grand Total:",
              controller.billDetails.value.grandTotal.toString(),
            ),
          ],
        );
      },
    ),
  );

  final pdfData = await pdf.save();

  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
}
