import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insudox/globals.dart';

class SearchDropDownFilter extends StatefulWidget {
  const SearchDropDownFilter({
    Key? key,
    required this.height,
    required this.width,
    required this.items,
    required this.optionValue,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);
  final List<String> items;
  final Function(dynamic) onChanged;
  final String? hintText;
  final double height, width;
  final ValueNotifier<int> optionValue;

  @override
  State<SearchDropDownFilter> createState() => _SearchDropDownFilterState();
}

class _SearchDropDownFilterState extends State<SearchDropDownFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        color: GlobalColor.searchFieldBackground,
        borderRadius: BorderRadius.circular(widget.height / 100),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.items[widget.optionValue.value],
          borderRadius: BorderRadius.circular(widget.height / 100),
          isDense: true,
          alignment: AlignmentDirectional.center,
          items: widget.items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontFamily: 'DM Sans',
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            widget.onChanged(widget.items.indexOf(value.toString()));
            setState(() {});
          },
        ),
      ),
    );
  }
}

class SearchFormField extends StatelessWidget {
  const SearchFormField({
    Key? key,
    required this.searchController,
    required this.hintText,
    required this.redirectFunction,
  }) : super(key: key);
  final TextEditingController searchController;
  final String hintText;
  final Function redirectFunction;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: GlobalColor.searchFieldBackground,
        borderRadius: BorderRadius.circular(screenHeight / 75),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Colors.black,
          fontSize: screenHeight / 50,
          fontFamily: 'DM Sans',
        ),
        controller: searchController,
        onChanged: (value) {
          // setState(() {});
        },
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: screenHeight / 50,
            fontFamily: 'DM Sans',
          ),
          fillColor: GlobalColor.searchFieldBackground,
          hintText: hintText,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.black,
              size: screenHeight / 50,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenHeight / 75),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenHeight / 75),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenHeight / 75),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenHeight / 75),
          ),
        ),
      ),
    );
  }
}
