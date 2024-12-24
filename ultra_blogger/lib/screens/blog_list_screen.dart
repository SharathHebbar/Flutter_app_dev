import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/blog_provider.dart';
import 'editor_screen.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogs = Provider.of<BlogProvider>(context).blogs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditorScreen()),
              );
            },
          ),
        ],
      ),
      body: blogs.isEmpty
          ? const Center(child: Text('No blogs available. Start writing!'))
          : ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return ListTile(
                  title: Text(blog.title),
                  subtitle: Text(
                    blog.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(blog.title),
                        content: Text(blog.content),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
