import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_learning/Component/internetService.dart';
import 'package:kids_learning/Component/web_view.dart';

import '/Model/m_learn.dart';

class CardVideo extends StatefulWidget {
  final ModellPages data;
  final String name;
  CardVideo({required this.data, required this.name});

  @override
  State<CardVideo> createState() => _CardVideoState();
}

class _CardVideoState extends State<CardVideo> {
  final RxBool isLoading = false.obs;
  final RxBool selected = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected.value = widget.name == widget.data.title;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        isLoading.value = true;
        bool serviceAvailable =
            await InternetCheckService.isInternetAvailable();
        isLoading.value = false;

        if (serviceAvailable) {
          var route = MaterialPageRoute(
              builder: (context) => AppWebView(
                    title: widget.data.title,
                    url: widget.data.pageUrl,
                  ));
          Navigator.push(context, route);
          print('index');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(
        color: Colors.red,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: 200,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          color: Colors.red[50],
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Obx(
                () => Expanded(
                  flex: 2,
                  child: selected.value && isLoading.value
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Image.network(
                          widget.data.imageUrl,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: Center(
                child: Text(widget.data.title,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    overflow: TextOverflow.ellipsis),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
