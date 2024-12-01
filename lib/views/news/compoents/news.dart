part of '../view.dart';
class ANewsSection extends StatefulWidget {

  final String category;
  const ANewsSection({super.key, required this.category});

  @override
  State<ANewsSection> createState() => _ANewsSectionState();
}

ApiServices apiServices = ApiServices();
late var future;

class _ANewsSectionState extends State<ANewsSection> {
  @override
  void initState() {
    future=apiServices.fetchNewsData(widget.category);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder(
            future: future,
            builder: (context,  AsyncSnapshot<NewsData?> snapshot) {
              if(snapshot.hasData)
                return _listItem(snapshot.data!.articles);
              else if(snapshot.hasError)
                return Center(child: Text(snapshot.error.toString(),style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
              else
                return Center(child: CircularProgressIndicator(color: Colors.green,backgroundColor: Colors.blue,strokeWidth: 6,));
            }
        ),
    );
  }



  Widget _listItem(List<Articles> articles) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          // gbloc.add(getANewsDataEvent(category: widget.category));
        }
        return true;
      },
      child: ListView.separated(
          itemBuilder: (context, index) =>  _item(articles[index]),
          separatorBuilder: (context, index) => Padding(
            padding:  EdgeInsetsDirectional.symmetric(vertical: 8),
            child: Divider(color: Colors.grey,thickness: 4,indent: 24,endIndent: 24,),
          ),
          itemCount: articles.length
      ),
    );
  }

  Widget _item(Articles article) {
    return Padding(
      padding:  EdgeInsetsDirectional.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(article: article,),));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(article.urlToImage!=null?article.urlToImage!:"",width: double.infinity,height: 160,fit: BoxFit.fill,errorBuilder: (context, error, stackTrace) => ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/category/notfoundimage.jpg",width: double.infinity,height: 160,fit: BoxFit.fill,)),)),
            SizedBox(height: 4,),
            Directionality(textDirection: TextDirection.ltr,child: Text(article.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),maxLines: 2,overflow: TextOverflow.ellipsis)),
            SizedBox(height: 4,),
            Directionality(textDirection: TextDirection.ltr,child: Text(article.description!=null?article.description!:"",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),maxLines: 3,overflow: TextOverflow.ellipsis,)),
            SizedBox(height: article.author!=null?4:0,),
          ],
        ),
      ),
    );
  }

  void _showProgressDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 500), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8,),
                Text(msg, style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor, fontWeight: FontWeight.bold, fontSize: 21),),
              ],
            ),
          );
        });
  }
}
