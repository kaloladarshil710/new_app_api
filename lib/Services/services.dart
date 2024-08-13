import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_app_api/model/new_model.dart';

class NewsApi {
  // for news home screen
  List<NewsModel> dataStore = [];
  Future<void> getNews() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=india&sortBy=publishedAt&apiKey=82e1dc126db5420ea42e259c8117cc54");

    // "https://newsapi.org/v2/everything?q=india&sortBy=publishedAt&apiKey=82e1dc126db5420ea42e259c8117cc54");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null &&
            element['content'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'], // name must be same fron api
            urlToImage: element['urlToImage'],
            description: element['description'],
            author: element['author'],
            content: element['content'],
          );
          dataStore.add(newsModel);
        }
      });
    }
  }
}



class CategoryNews {
  List<NewsModel> dataStore = [];

  Future<void> getNews(String category) async {
    Uri url = Uri.parse(
        // "https://newsapi.org/v2/top-headlines?category=$category&apiKey=82e1dc126db5420ea42e259c8117cc54");
"https://newsapi.org/v2/everything?q=$category&sortBy=publishedAt&apiKey=82e1dc126db5420ea42e259c8117cc54");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    print("API Response: $jsonData"); // Debugging line

    if (jsonData["status"] == 'ok' ) {
      jsonData["articles"].forEach((element) {
        if (element['content'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            author: element['author'],
            content: element['content'],
          );
          dataStore.add(newsModel);
        }
      });
    } else {
      print("No articles found for category: $category"); // Debugging line
    }
  }
}


// class CategoryNews {
//   // for news home screen
//   List<NewsModel> dataStore = [];
//   Future<void> getNews(String category) async {
//     Uri url = Uri.parse(
//         "https://newsapi.org/v2/top-headlines?category=$category&apiKey=82e1dc126db5420ea42e259c8117cc54");
//         // "https://newsapi.org/v2/everything?category=$category&apiKey=82e1dc126db5420ea42e259c8117cc54");
//     var response = await http.get(url);
//     var jsonData = jsonDecode(response.body);
//
//     if (jsonData["status"] == 'ok') {
//       jsonData["articles"].forEach((element) {
//         if (element['urlToImage'] != null &&
//             element['description'] != null &&
//             element['author'] != null &&
//             element['content'] != null) {
//           NewsModel newsModel = NewsModel(
//             title: element['title'], // name must be same fron api
//             urlToImage: element['urlToImage'],
//             description: element['description'],
//             author: element['author'],
//             content: element['content'],
//           );
//           dataStore.add(newsModel);
//         }
//       });
//     }
//   }
// }
// for category news
// we have used the free news api. for that, first you need to create a account and  then login 
// after that get the api key  