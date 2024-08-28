import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class RecipeController extends GetxController {
  Future<void> downloadRecipeAsPDF(
      String recipeTitle, String recipeContent) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(recipeTitle,
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text(recipeContent, style: const pw.TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );

    try {
      final output = await getTemporaryDirectory();
      final filePath = '${output.path}/$recipeTitle.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      Get.snackbar(
        'Download Complete',
        'Recipe saved as PDF at $filePath',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to save PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
