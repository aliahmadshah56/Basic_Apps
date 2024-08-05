import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

const String NEWS_API_KEY = "69514a079325426e8ca97d9fa2fb25ca";
const String PLACEHOLDER_IMAGE_LINK = 'https://via.placeholder.com/150';

class IphoneNewsPage extends StatefulWidget {
  const IphoneNewsPage({super.key});

  @override
  State<IphoneNewsPage> createState() => _IphoneNewsPageState();
}

class _IphoneNewsPageState extends State<IphoneNewsPage> {
  final Dio dio = Dio();
  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getIphoneNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text('iPhone News', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildUi(),
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
            height: 100, // Adjust height as needed
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

  Future<void> _getIphoneNews() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/everything?q=Apple&from=2024-08-04&sortBy=popularity&apiKey=${NEWS_API_KEY}',
      );

      final articlesJson = response.data["articles"] as List;
      setState(() {
        articles = articlesJson.map((a) => Article.fromJson(a)).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching iPhone news: $e');
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
