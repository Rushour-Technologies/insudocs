import 'package:flutter/material.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/classes/client_data_model.dart';
import 'package:insudox/src/classes/insurance_ENUMS.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClientsTable extends StatefulWidget {
  const ClientsTable({super.key});

  @override
  State<ClientsTable> createState() => _ClientsTableState();
}

class _ClientsTableState extends State<ClientsTable> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TableFilters(),
        Table(
            border: TableBorder.all(
              color: GlobalColor.transparent,
              width: 0,
            ),
            children: [
              // Header row
              TableRow(
                children: [
                  CustomTableCell(
                    data: 'Name',
                    isHeader: true,
                  ),
                  CustomTableCell(
                    data: 'Insurance Type',
                    isHeader: true,
                  ),
                  CustomTableCell(
                    data: 'Claim / Track',
                    isHeader: true,
                  ),
                  CustomTableCell(
                    data: 'Email',
                    isHeader: true,
                  ),
                  CustomTableCell(
                    data: 'Report',
                    isHeader: true,
                  ),
                ],
              ),
            ]),
        SizedBox(
          height: screenHeight * 0.45,
          child: SingleChildScrollView(
            child: Table(
              children: clientDataList
                  .map(
                    (client) => TableRow(
                      children: [
                        CustomTableCell(data: client.name),
                        CustomTableCell(
                            data: InsuranceType
                                .values[client.insuranceType].data),
                        CustomTableCell(
                          data: InsuranceStatus
                              .values[client.insuraceStatus].data,
                        ),
                        CustomTableCell(data: client.email),
                        CustomTableCell(
                          data: 'Download',
                          link: client.reportLink,
                          isLink: true,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        // Data rows
      ],
    );
  }
}

ClientDataModel clientDataModel = ClientDataModel(
  name: 'John Doe',
  insuranceType: 1,
  insuraceStatus: 0,
  email: 'pataderushikesh@gmail.com',
  reportLink: 'https://www.google.com',
);
List<ClientDataModel> clientDataList =
    List.generate(20, (index) => clientDataModel);

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({
    Key? key,
    required this.data,
    this.isHeader = false,
    this.isLink = false,
    this.link = "",
  }) : super(key: key);
  final String data, link;
  final bool isHeader, isLink;

  static const TextStyle headerStyle = TextStyle(
    color: GlobalColor.white,
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.bold,
  );

  static const TextStyle dataStyle = TextStyle(
    color: GlobalColor.black,
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.normal,
  );

  static const TextStyle linkStyle = TextStyle(
    color: GlobalColor.link,
    fontFamily: 'DM Sans',
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return TableCell(
      child: Card(
        color: isHeader ? GlobalColor.secondary : GlobalColor.white,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: screenHeight * 0.05,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01,
              ),
              child: isLink
                  ? TextButton(
                      style: TextButton.styleFrom(),
                      onPressed: () async {
                        await launchUrlString(link);
                      },
                      child: Text(
                        data,
                        style: linkStyle,
                      ),
                    )
                  : Text(
                      data,
                      style: isHeader ? headerStyle : dataStyle,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class TableFilters extends StatelessWidget {
  const TableFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
