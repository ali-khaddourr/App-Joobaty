import 'package:flutter/material.dart';

class QuestionsBar extends StatelessWidget {
  const QuestionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
        
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Theme.of(context).shadowColor,
                          ),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 14),
                              hintText: 'Search Keyword'),
                        ),
                      ),
                   
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: 5,
         
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Card(
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    'question  question  question widget quon widget questoon',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        'answer answer answer answer answer answer answer answer answer answer vv answer answer answer',
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 77, 76, 76)),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Answered 10 May 2017'),
                            Text(
                              'See 56 answers',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
