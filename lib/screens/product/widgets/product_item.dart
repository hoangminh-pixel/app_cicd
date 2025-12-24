part of '../product_screen.dart';

class ProductItem extends StatelessWidget {
  final Product prod;
  const ProductItem({super.key, required this.prod});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 2,
        //     offset: const Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          prod.imageUrl.isNotEmpty
              ? Image.network(
                  prod.imageUrl,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image,
                        size: 100, color: Colors.grey);
                  },
                )
              : const Icon(Icons.image),
          const SizedBox(
            height: 6,
          ),
          Text(
            prod.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          prod.isNew
              ? Column(
                  children: [
                    Text(
                      "Còn: ${prod.stock}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      Formatter.formatter.format(prod.price),
                      style: const TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("NEW",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "Còn: ${prod.stock}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      Formatter.formatter.format(prod.price),
                      style: const TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
