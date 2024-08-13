import 'package:flutter/material.dart';
import 'package:new_app_api/Services/services.dart';
import 'package:new_app_api/model/new_model.dart';
import 'package:new_app_api/Screen/news_detail.dart';

class SelectedCategoryNews extends StatefulWidget {
  final String category;

  const SelectedCategoryNews({super.key, required this.category});

  @override
  State<SelectedCategoryNews> createState() => _SelectedCategoryNewsState();
}

class _SelectedCategoryNewsState extends State<SelectedCategoryNews> {
  List<NewsModel> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    CategoryNews news = CategoryNews();
    try {
      await news.getNews(widget.category);
      setState(() {
        articles = news.dataStore;
        isLoading = false;
      });
    } catch (e) {
      // Handle any errors that occur during fetching
      setState(() {
        isLoading = false;
      });
      print("Error fetching news: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          widget.category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : articles.isEmpty
          ? const Center(
        child: Text("No news available for this category."),
      )
          : ListView.builder(
        itemCount: articles.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetail(newsModel: article),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      article.urlToImage ?? 'https://via.placeholder.com/400',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 250);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.title ?? 'No title',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Divider(thickness: 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
