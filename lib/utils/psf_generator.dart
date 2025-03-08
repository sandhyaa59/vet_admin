import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vet_pharma/controller/bill_details_controller.dart';
import 'package:vet_pharma/model/bill_details_response.dart';

final controller = Get.find<BillDetailsController>();

class BillPdfGenerator {
  static Future<void> generateAndPrintBill(
    BillDetailsResponse billDetails,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: 10),
              pw.Text("Customer Details",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text(
                  "Name: ${controller.billDetails.value.customerName ?? ''}"),
              pw.Text(
                  "Contact: ${controller.billDetails.value.customerMobileNo ?? ''}"),
              pw.Text(
                  "Email: ${controller.billDetails.value.customerEmail ?? ''}"),
              pw.Text(
                  "Shop: ${controller.billDetails.value.orderResponse?.shopName ?? ''}"),
              pw.Text(
                  "Customer PAN: ${controller.billDetails.value.orderResponse?.customerPan ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Order Details",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text(
                  "Order Status: ${controller.billDetails.value.orderResponse?.status ?? ''}"),
              pw.Text(
                  "Order Date: ${controller.billDetails.value.orderResponse?.addedDateTime ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Employee Details",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text(
                  "Employee Name: ${controller.billDetails.value.orderResponse?.employeeName ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Bill Details",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text("Bill No: ${controller.billDetails.value.billNo}"),
              pw.Text(
                  "Bill Date: ${controller.billDetails.value.createdAt ?? ''}"),
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
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
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
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Quantity",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Unit",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Price",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
              if ((controller.billDetails.value.orderResponse?.description ??
                      "")
                  .isNotEmpty)
                pw.Text(
                    "Description: ${controller.billDetails.value.orderResponse?.description}",
                    style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 10),
              pw.Text("Summary",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text("Sub Total: ${controller.billDetails.value.subTotal}"),
              pw.Text("Discount: ${controller.billDetails.value.discounts}"),
              pw.Text("Tax: ${controller.billDetails.value.tax}"),
              pw.Text("Due: ${controller.billDetails.value.dueAmount}"),
              pw.Text("Received: ${controller.billDetails.value.received}"),
              pw.Text("Grand Total: ${controller.billDetails.value.grandTotal}",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    final pdfData = await pdf.save();

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
  }
}
