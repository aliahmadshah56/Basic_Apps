import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

const String NEWS_API_KEY = "69514a079325426e8ca97d9fa2fb25ca";
const String PLACEHOLDER_IMAGE_LINK = 'https://via.placeholder.com/150';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final Dio dio = Dio();

  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getBbcNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text('News', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (articles.isEmpty) {
      return Center(
        child: Text('No articles found'),
      );
    } else {
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            onTap: () {
              _launchUrl(article.url ?? "");
            },
            contentPadding: EdgeInsets.all(8.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  article.urlToImage ?? PLACEHOLDER_IMAGE_LINK,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8.0),

                Text(
                  article.title ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  article.publishedAt ?? "",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<void> _getBbcNews() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=${NEWS_API_KEY}',
      );

      final articlesJson = response.data["articles"] as List;
      setState(() {
        articles = articlesJson.map((a) => Article.fromJson(a)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching BBC news: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
