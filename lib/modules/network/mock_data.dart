class MockData {
  static List<Map<String, dynamic>> posts = List.generate(10, (index) => {
    'id': index + 1,
    'title': '文章标题 ${index + 1}',
    'content': '这是第 ${index + 1} 篇文章的内容。这里可以展示一些示例数据，用于演示列表功能。',
    'author': '作者 ${index + 1}',
    'date': '2024-01-${index + 1 < 10 ? '0${index + 1}' : index + 1}',
  });

  static List<String> carouselImages = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png',
  ];

  static List<Map<String, String>> carouselItems = [
    {'image': 'assets/images/slide1.png', 'title': '轮播图 1', 'description': '这是第一张轮播图的描述'},
    {'image': 'assets/images/slide2.png', 'title': '轮播图 2', 'description': '这是第二张轮播图的描述'},
    {'image': 'assets/images/slide3.png', 'title': '轮播图 3', 'description': '这是第三张轮播图的描述'},
  ];
}

