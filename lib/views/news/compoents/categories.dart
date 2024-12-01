part of '../view.dart';

class NewsCategories extends StatefulWidget {
  const NewsCategories({super.key});

  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

List<Category> categories=[];
String m_category="general";

class _NewsCategoriesState extends State<NewsCategories> {
  @override
  Widget build(BuildContext context) {
    categories=getCategories();
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
          itemBuilder: (context, index) => _categoryItem(categories[index]),),
    );
  }

 Widget _categoryItem(Category category) {
    return Padding(
      padding:  EdgeInsetsDirectional.only(end: 8),
      child: GestureDetector(
        onTap: () {
           // m_category=category.title;
            //future=apiServices.fetchNewsData(m_category);
            //setState(() {});
          Navigator.push(context, MaterialPageRoute(builder: (context) => ANewsSection(category: category.title),));
        },
        child: Container(
          alignment: AlignmentDirectional.bottomCenter,
          width: 150,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/category/${category.image}"),fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Text(category.title,style: TextStyle(color: Colors.red,fontSize: 21,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
        ),
      ),
    );
 }
}
