import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile{

  Map<int, bool> downloadStates = {};
  void _setDownloadState(int index, bool isDownloading) {
    downloadStates[index] = isDownloading;
  }

  Future<void> downloadFile(BuildContext context,String url, String file,int index) async {
    Dio dio = Dio();
    _setDownloadState(index,true);
    String _sanitizeFileName(String fileName) {
      return fileName.replaceAll(RegExp(r'[<>:"/\\|?*]'), '');
    }
    String _truncateFileName(String fileName, int maxLength) {
      return (fileName.length <= maxLength) ? fileName : fileName.substring(0, maxLength);
    }
    String sanitizedFileName = _sanitizeFileName(file);
    String truncatedFileName = _truncateFileName(sanitizedFileName, 20);
    String fileName = "$truncatedFileName.pdf";
    String path = await getFilePath(fileName);
    String baseUrl = url;

    try {
      await dio.download(
        baseUrl,
        path,
        deleteOnError: true,
      ).then((_) {
        _setDownloadState(index,true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Download completed: $path')));
      });
    } catch (e) {
      _setDownloadState(index,true);
      print("Exception$e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Download failed')));
    }
  }

  Future<String> getFilePath(String filename) async {
    Directory? dir;
    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        dir = Directory('/storage/emulated/0/Download/');
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }
  bool isDownloading(int index) {
    return downloadStates[index] ?? false;
  }
}

