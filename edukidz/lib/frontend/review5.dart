import 'package:flutter/material.dart';

class ReviewsPage5 extends StatefulWidget {
  final Map<String, Map<String, String>> reviews;
  final void Function(String videoId, String replyText) onReply;

  const ReviewsPage5({
    Key? key,
    required this.reviews,
    required this.onReply,
  }) : super(key: key);

  @override
  State<ReviewsPage5> createState() => _ReviewsPage5State();
}

class _ReviewsPage5State extends State<ReviewsPage5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Reviews',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey[200],
          ),
        ),
      ),
      body: widget.reviews.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: widget.reviews.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final entry = widget.reviews.entries.elementAt(index);
          return _buildReviewCard(context, entry.key, entry.value);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada review',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Review akan muncul di sini',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, String videoId, Map<String, String> reviewData) {
    final review = reviewData['review'] ?? '';
    final reply = reviewData['reply'] ?? '';
    final hasReply = reply.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with subject and icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getSubjectColor(videoId).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getSubjectIcon(videoId),
                    color: _getSubjectColor(videoId),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _getTitleFromVideoId(videoId),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Review content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Komentar',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Reply section (if exists)
            if (hasReply) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[100]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.reply,
                          size: 16,
                          color: Colors.blue[700],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Balasan Anda',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[700],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reply,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[800],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showReplyDialog(context, videoId),
                icon: Icon(
                  hasReply ? Icons.edit : Icons.reply,
                  size: 18,
                ),
                label: Text(
                  hasReply ? 'Edit Balasan' : 'Balas',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasReply ? Colors.orange[600] : Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReplyDialog(BuildContext context, String videoId) {
    final controller = TextEditingController();
    final currentReply = widget.reviews[videoId]?['reply'] ?? '';

    // Pre-fill with existing reply if editing
    if (currentReply.isNotEmpty) {
      controller.text = currentReply;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.reply,
              color: Colors.blue[600],
              size: 24,
            ),
            const SizedBox(width: 12),
            const Text(
              'Balas Review',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review untuk: ${_getTitleFromVideoId(videoId)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tulis balasan Anda...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                widget.onReply(videoId, controller.text.trim());
                Navigator.pop(context);
                // Trigger rebuild untuk menampilkan balasan baru
                setState(() {});
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  String _getTitleFromVideoId(String videoId) {
    switch (videoId) {
      case 'ywHJTuoJBjs':
        return 'Bahasa Indonesia';
      case 'nTKhW5mnhwo':
        return 'Matematika';
      case 'ZuETFQKw_DM':
        return 'Bahasa Inggris';
      default:
        return 'Video tidak dikenal';
    }
  }

  IconData _getSubjectIcon(String videoId) {
    switch (videoId) {
      case 'ywHJTuoJBjs':
        return Icons.language;
      case 'nTKhW5mnhwo':
        return Icons.calculate;
      case 'ZuETFQKw_DM':
        return Icons.translate;
      default:
        return Icons.video_library;
    }
  }

  Color _getSubjectColor(String videoId) {
    switch (videoId) {
      case 'ywHJTuoJBjs':
        return Colors.green;
      case 'nTKhW5mnhwo':
        return Colors.purple;
      case 'ZuETFQKw_DM':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}