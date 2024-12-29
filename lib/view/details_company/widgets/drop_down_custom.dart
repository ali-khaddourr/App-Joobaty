import 'package:flutter/material.dart';

class DropDownCustom extends StatelessWidget {
  final String? selectValue;
  final void Function(String?)? onChanged;
  final String hint;
  const DropDownCustom({super.key, required this.selectValue, this.onChanged, required this.hint});

  @override
  Widget build(BuildContext context) {
    return   Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color.fromARGB(255, 122, 122, 122))),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                  ),
                                  isExpanded: true,
                                  value: selectValue,
                                  hint: Text(hint),
                                  onChanged: onChanged,
                                  items: <String>[
                                    'Mr.',
                                    'Mrs.',
                                    'Miss',
                                    'Dr.',
                                    'Prof.',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
  }
}