import 'package:flutter/material.dart';

class CvCard extends StatelessWidget {
  final String cvTitle;
  final String defaultStatus;
  final String addedDate;
  final VoidCallback onDelete;

  CvCard({
    required this.cvTitle,
    required this.defaultStatus,
    required this.addedDate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CV Title
            Text(
              cvTitle,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Default Status and Added Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Default Status
                Text(
                  defaultStatus,
                  style: TextStyle(
                    color: defaultStatus == 'Default' ? Colors.green : Colors.red,
                  ),
                ),

                // Added Date
                Text(
                  addedDate,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 15),

            // Actions: View and Delete
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // View CV Button

                SizedBox(width: 10),

                // Delete Button
                TextButton.icon(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
