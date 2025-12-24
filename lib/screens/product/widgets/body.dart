part of '../product_screen.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  String? selectedCategory = 'Tất cả';
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<String> categories =
        mockProducts.map((p) => p.category).toSet().toList();
    categories.insert(0, 'Tất cả');

    // Lọc theo category + search
    final filtered = mockProducts.where((p) {
      final matchCategory = selectedCategory == 'Tất cả'
          ? true
          : p.category == selectedCategory;
      final matchSearch = p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.code.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm theo tên hoặc mã...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  final isSelected = item == selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = item;
                      });
                    },
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey,
                          ),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final p = filtered[index];
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: p),
                        ),
                      );
                      setState(() {});
                    },
                    child: ProductItem(
                      prod: p,
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.66,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
