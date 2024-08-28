import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class RecipeController extends GetxController {
  Future<void> downloadRecipeAsPDF(String recipeTitle, String recipeContent) async {
    print('Pressed');
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(recipeTitle, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text(recipeContent, style: const pw.TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );

    try {
      final output = await getTemporaryDirectory();
      print("Directory obtained: ${output.path}");
      final filePath = '${output.path}/$recipeTitle.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      print("PDF saved successfully at $filePath");

      Get.snackbar('Download Complete', 'Recipe saved as PDF at $filePath');
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to save PDF: $e');
    }
  }
}
