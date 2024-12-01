import 'package:flutter/material.dart';
import 'package:flutter_dio_futurebuilder/model/news_model.dart';


import '../../apis/apis_service.dart';
import 'model/categories.dart';
part 'compoents/details.dart';

part 'compoents/categories.dart';
part 'compoents/news.dart';


class MyNews extends StatelessWidget {

  const MyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "News",style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold)
                ),
                TextSpan(
                    text: "app",style: TextStyle(color: Colors.amber,fontSize: 24,fontWeight: FontWeight.w600)
                ),
              ]
            )
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          NewsCategories(),
          SizedBox(height: 16,),
          Expanded(child: ANewsSection(category: m_category)),
          SizedBox(height: 8,),
        ],
      ),
    );
  }
}
