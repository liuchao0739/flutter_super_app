import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../widgets/document_card.dart';
import 'document_detail_page.dart';

/// 文档列表页
class DocumentListPage extends StatefulWidget {
  const DocumentListPage({Key? key}) : super(key: key);

  @override
  State<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  final List<Document> _documents = [
    Document(
      id: 'doc_001',
      title: '项目需求文档',
      content: '这是项目需求文档的内容...',
      type: 'doc',
      ownerId: 'user_001',
      ownerName: '张三',
      updateTime: DateTime.now().subtract(const Duration(hours: 2)),
      isShared: true,
      viewCount: 45,
    ),
    Document(
      id: 'doc_002',
      title: '项目进度表',
      content: '这是项目进度表的内容...',
      type: 'sheet',
      ownerId: 'user_002',
      ownerName: '李四',
      updateTime: DateTime.now().subtract(const Duration(days: 1)),
      isShared: false,
      viewCount: 12,
    ),
    Document(
      id: 'doc_003',
      title: '产品演示PPT',
      content: '这是产品演示PPT的内容...',
      type: 'slide',
      ownerId: 'user_003',
      ownerName: '王五',
      updateTime: DateTime.now().subtract(const Duration(hours: 5)),
      isShared: true,
      viewCount: 89,
    ),
    Document(
      id: 'doc_004',
      title: '技术架构设计',
      content: '这是技术架构设计的内容...',
      type: 'doc',
      ownerId: 'user_001',
      ownerName: '张三',
      updateTime: DateTime.now().subtract(const Duration(days: 2)),
      isShared: true,
      viewCount: 156,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文档'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: 创建新文档
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('TODO: 创建新文档')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _documents.length,
        itemBuilder: (context, index) {
          final doc = _documents[index];
          return DocumentCard(
            document: doc,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentDetailPage(document: doc),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

