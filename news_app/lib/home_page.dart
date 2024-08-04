// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

const String NEWS_API_KEY = "69514a079325426e8ca97d9fa2fb25ca";
const String PLACEHOLDER_IMAGE_LINK = 'https://example.com/placeholder.jpg';

class HomePage extends StatefulWidget {
  final String country;

  const HomePage({super.key, required this.country});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio dio = Dio();

  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ListTile(
          onTap: () {
            _launchUrl(article.url ?? "");
          },
          leading: Image.network(
            article.urlToImage ?? PLACEHOLDER_IMAGE_LINK,
            height: 250,
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(
            article.title ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(article.publishedAt ?? ""),
        );
      },
    );
  }

  Future<void> _getNews() async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=${widget.country}&apiKey=${NEWS_API_KEY}',
      );

      final articlesJson = response.data["articles"] as List;
      setState(() {
        articles = articlesJson.map((a) => Article.fromJson(a)).toList();
      });
    } catch (e) {
      print('Error fetching news: $e');
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
