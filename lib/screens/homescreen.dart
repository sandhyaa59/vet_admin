import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vet_pharma/utils/constants.dart';
import 'package:vet_pharma/utils/drawer.dart';
import 'package:vet_pharma/widgets/appbar.dart';
import 'package:vet_pharma/widgets/organization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar:  AppBars(context),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return  Container(
                padding: const EdgeInsets.all(kPadding),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                     organizationDetails(),
                     const SizedBox(
          height: 50.0,
        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.size.width*0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Check In - Check Out ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0),
                                        ), const SizedBox(width: 10.0),
                                        TextButton(
                                            onPressed: () {},
                                            child:const Text(
                                              "View All ",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0),
                                            )),
                                      ],
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                        elevation: 2.0,
                                        child: Container(
                                          width: Get.size.width*0.4,
                                            padding: const EdgeInsets.all(12),
                                            child: checkInCheckOutTable())),
                
                              ],
                            ),
                          ),
                          // SingleChildScrollView(
                          //     child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           const SizedBox(height: 20.0),
                                    
                          //           const SizedBox(height: 10.0),
                                    
                          //         ],
                          //       ),
                          //     ),
                           
                        
                
                      //  const    SizedBox(width: 20.0),
                          Container(
                            width: Get.size.width*0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Employee Management",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0),
                                        ), const SizedBox(width: 10.0),
                                        TextButton(
                                            onPressed: () {},
                                            child:const Text(
                                              "View All ",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0),
                                            )),
                                      ],
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                        elevation: 2.0,
                                        child: Container(
                                          width: Get.size.width*0.4,
                                            padding: const EdgeInsets.all(12),
                                            child: trackingEmployeeTable())),
                
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                
              );
            } 
            else {
              return  Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     organizationDetails(),
                     const SizedBox(
          height: 50.0,
        ),
                    SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Check In Check Out ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child:const Text(
                                      "View All ",
                                      style: TextStyle(
                                        color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              ),
                                elevation: 2.0,
                                child: Container(
                                  width: double.maxFinite,
                                    padding: const EdgeInsets.all(12),
                                    child: checkInCheckOutTable())),
                          ],
                        ),
                      ),
                    

                const    SizedBox(height: 20.0),
                                         SingleChildScrollView(
                            child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tracking",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18.0),
                          ),
                           TextButton(
                                    onPressed: () {},
                                    child:const Text(
                                      "View All ",
                                      style: TextStyle(
                                        color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Card(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              ),
                          elevation: 2.0,
                          child: Container(width: double.maxFinite,
                              padding: const EdgeInsets.all(12),
                              child: trackingEmployeeTable())),
                    ]))
                  ],
                ),
              );
            }
          }),
        ));
  }

  Widget checkInCheckOutTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'SN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'DateTime',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: const [
            DataRow(cells: <DataCell>[
              DataCell(Text("1")),
              DataCell(
                Text("sandhyaa"),
              ),
              DataCell(Text("tiwariii"))
            ])
          ],
        ));
  }



  Widget trackingEmployeeTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'SN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'DateTime',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: const [
            DataRow(cells: <DataCell>[
              DataCell(Text("1")),
              DataCell(
                Text("sandipp"),
              ),
              DataCell(Text("tiwariii"))
            ])
          ],
        ));
  }

Widget checkIncheckOutProtraitMode(){
  return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Check In - Check Out ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child:const Text(
                                      "View All ",
                                      style: TextStyle(
                                        color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              ),
                                elevation: 2.0,
                                child: Container(
                                  width: double.maxFinite,
                                    padding: const EdgeInsets.all(12),
                                    child: checkInCheckOutTable())),
                          ],
                        ),
                      );
}


  Widget trackingEmployeeProtraitMode(){
    return Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Check In Check Out ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child:const Text(
                                      "View All ",
                                      style: TextStyle(
                                        color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              ),
                                elevation: 2.0,
                                child: Container(
                                  width: double.maxFinite,
                                    padding: const EdgeInsets.all(12),
                                    child: checkInCheckOutTable())),
                          ],
                        ),
                      ),
                    

                const    SizedBox(height: 20.0),
                                         SingleChildScrollView(
                            child: Column(children: [
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tracking",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18.0),
                          ),
                           TextButton(
                                    onPressed: () {},
                                    child:const Text(
                                      "View All ",
                                      style: TextStyle(
                                        color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    )),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Card(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              ),
                          elevation: 2.0,
                          child: Container(width: double.maxFinite,
                              padding: const EdgeInsets.all(12),
                              child: trackingEmployeeTable())),
                    ]))
                  ],
                ),
              );
  }
}
