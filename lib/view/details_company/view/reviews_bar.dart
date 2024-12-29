import 'package:flutter/material.dart';

class ReviewsBar extends StatefulWidget {
  const ReviewsBar({super.key});

  @override
  State<ReviewsBar> createState() => _ReviewsBarState();
}

class _ReviewsBarState extends State<ReviewsBar> {
  String? _select;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Sort By : ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,),),
                  Expanded(
                    child: Container(
                            
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.red,
                                    ),
                                    isExpanded: true,
                                    value: _select,
                                   
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        setState(() {
                                          _select = value;
                                        });
                                      }
                                    },
                                    items: <String>[
                                      'Helpfulness',
                                      'Rating',
                                      'Date',
                                      
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                  ),
            ],
          )
        ],
      ),
    );
  }
}