import 'package:flutter/material.dart';
import 'dart:ui';
import 'events_page.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final double discount = (event.originalPrice > 0)
        ? ((event.originalPrice - event.price) / event.originalPrice) * 100
        : 0.0;

    return Card(
      color: const Color.fromARGB(255, 35, 34, 34),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                event.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    color: const Color.fromARGB(255, 98, 98, 98),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: const Color.fromARGB(255, 98, 98, 98),
                    child: const Center(
                      child: Icon(Icons.image_not_supported,
                          color: Colors.white, size: 50),
                    ),
                  );
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 43, 43, 43)
                            .withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_border,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 12,
                child: Text(
                  event.displayDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    shadows: [Shadow(blurRadius: 2.0, color: Colors.black)],
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 12,
                child: Text(
                  'Only ${event.slotsLeft} Slots left',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 224, 123, 115),
                    fontSize: 12,
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    shadows: [Shadow(blurRadius: 2.0, color: Colors.black)],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Colors.yellow, size: 16),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        event.location,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        event.category,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  event.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    // fontFamily: 'Oswald',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'AED ${event.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (discount > 0)
                      Text(
                        'AED ${event.originalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    if (discount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 107, 64, 235),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${discount.toStringAsFixed(0)}% OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
