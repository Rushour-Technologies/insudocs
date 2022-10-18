import 'package:flutter/material.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/src/classes/client_model.dart';
import 'package:insudox/src/classes/insurance_ENUMS.dart';
import 'package:insudox/src/main/components/default.dart';
import 'package:insudox/src/main/components/search_fields.dart';
import 'package:insudox/src/main/tabs/clients/components/notification_send_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClientsTable extends StatefulWidget {
  const ClientsTable({super.key});

  @override
  State<ClientsTable> createState() => _ClientsTableState();
}

class _ClientsTableState extends State<ClientsTable> {
  final ValueNotifier<int> filterType = ValueNotifier<int>(0);
  final ValueNotifier<int> filterStatus = ValueNotifier<int>(0);
  final ValueNotifier<String> name = ValueNotifier<String>('');
  final ValueNotifier<bool> filterOn = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TableFilters(
          filterOn: filterOn,
          filterStatus: filterStatus,
          filterType: filterType,
          name: name,
          setState: setState,
        ),
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
                  )
                ],
              )
            ]),
        SizedBox(
          height: screenHeight * 0.65,
          child: SingleChildScrollView(
            child: Table(
              children: clientDataList
                  .where((element) =>
                      !filterOn.value ||
                      InsuranceStatus.values[element.insuraceStatus].data ==
                              InsuranceStatus.values[filterStatus.value].data &&
                          InsuranceType.values[element.insuranceType].data ==
                              InsuranceType.values[filterType.value].data)
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
                        )
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

ClientModel clientDataModel(
  int insuranceType,
  int insuranceStatus,
) =>
    ClientModel(
      name: 'John Doe',
      insuranceType: insuranceType,
      insuraceStatus: insuranceStatus,
      email: 'pataderushikesh@gmail.com',
      reportLink: 'https://www.google.com',
      uid: '123',
      photoURL: DEFAULT_PROFILE_PICTURE,
    );
List<ClientModel> clientDataList =
    List.generate(20, (index) => clientDataModel(index % 2, index % 3));

class CustomTableCell extends StatelessWidget {
  const CustomTableCell(
      {Key? key,
      required this.data,
      this.isHeader = false,
      this.isLink = false,
      this.link = ""})
      : super(key: key);
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
  const TableFilters(
      {super.key,
      required this.filterOn,
      required this.setState,
      required this.filterType,
      required this.filterStatus,
      required this.name});

  final ValueNotifier<bool> filterOn;
  final ValueNotifier<int> filterType;
  final ValueNotifier<int> filterStatus;
  final ValueNotifier<String> name;
  final void Function(Function()) setState;

  static final TextEditingController _searchController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final TextStyle headerStyle = TextStyle(
      color: GlobalColor.white,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.bold,
      fontSize: screenWidth * 0.015,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.02),
        // boxShadow: defaultBoxShadow(),
        color: GlobalColor.tertiary,
      ),
      child: ListTile(
        tileColor: GlobalColor.tertiary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Table Filters',
              style: headerStyle,
            ),
            Column(
              children: [
                Text(
                  "Filter : ${filterOn.value ? 'On' : 'Off'}",
                  style: TextStyle(
                    color: GlobalColor.black,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.01,
                  ),
                ),
                Switch(
                  activeColor: GlobalColor.primary,
                  value: filterOn.value,
                  onChanged: (value) {
                    setState(() {
                      filterOn.value = !filterOn.value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenHeight * 0.02),
        ),
        subtitle: Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: screenHeight * 0.1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01,
                horizontal: screenWidth * 0.015,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                        SizedBox(
                          width: screenWidth * 0.5,
                          child: formField(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Search a name',
                              controller: _searchController,
                              validator: (value) {
                                name.value = value ?? '';

                                return "";
                              },
                              setState: () {},
                              errorText: ''),
                        ),
                      ] +
                      (filterOn.value
                          ? [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  formTitle(
                                      screenHeight: screenHeight * 0.75,
                                      title: 'Insurance Type'),
                                  SizedBox(
                                    width: screenWidth * 0.06,
                                    child: SearchDropDownFilter(
                                      height: screenHeight * 0.05,
                                      width: screenWidth,
                                      items: InsuranceType.values
                                          .map((e) => e.data)
                                          .toList(),
                                      optionValue: filterType,
                                      onChanged: (value) {
                                        filterType.value = value;
                                        setState(() {});
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  formTitle(
                                      screenHeight: screenHeight * 0.75,
                                      title: 'Insurance Status'),
                                  SizedBox(
                                    width: screenWidth * 0.06,
                                    child: SearchDropDownFilter(
                                      height: screenHeight * 0.05,
                                      width: screenWidth,
                                      items: InsuranceStatus.values
                                          .map((e) => e.data)
                                          .toList(),
                                      optionValue: filterStatus,
                                      onChanged: (value) {
                                        filterStatus.value = value;
                                        print(filterStatus.value);
                                        print(filterType.value);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ]
                          : [])),
            ),
          ),
        ),
      ),
    );
  }
}
