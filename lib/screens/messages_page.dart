import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'dart:ui';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with TickerProviderStateMixin {
  int _selectedChatIndex = 0;

  bool get isDesktop => MediaQuery.of(context).size.width >= 900;

  final List<_ChatPreview> _chats = const [
    _ChatPreview(
      title: '12.A Osztály',
      lastMessage: 'Holnap dolgozat lesz?',
    ),
    _ChatPreview(
      title: 'Osztálykirándulás 2025',
      lastMessage: 'Indulás reggel 7-kor',
    ),
  ];

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated background gradient (matching main page)
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.5 + (_pulseAnimation.value - 1) * 0.5,
                    colors: [
                      const Color(0xFF1A1A1A).withOpacity(0.6),
                      const Color(0xFF0A0A0F),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Content
        SafeArea(
          child: isDesktop
              ? Row(
                  children: [
                    _buildChatList(context),
                    Expanded(child: _buildChatView(context)),
                  ],
                )
              : _buildChatList(context),
        ),
      ],
    );
  }

  // ---------------- CHAT LIST ----------------
  Widget _buildChatList(BuildContext context) {
    return Container(
      width: isDesktop ? 320 : null,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ListView.builder(
            itemCount: _chats.length,
            itemBuilder: (context, index) {
              final chat = _chats[index];
              return _ChatListItem(
                chat: chat,
                selected: index == _selectedChatIndex,
                onTap: () {
                  if (isDesktop) {
                    setState(() => _selectedChatIndex = index);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(chat: chat),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // ---------------- CHAT VIEW ----------------
  Widget _buildChatView(BuildContext context) {
    final chat = _chats[_selectedChatIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // header
          _buildGlassHeader(chat.title),

          const SizedBox(height: 24),

          // messages placeholder
          Expanded(
            child: _buildGlassCard(
              child: Center(
                child: Text(
                  'Üzenetek helye',
                  style: TextStyle(color: AppColors.text(context)),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // input
          _buildGlassCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Üzenet írása...',
                        hintStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widgets (copied/adapted from main page)
  Widget _buildGlassHeader(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFFFFF).withOpacity(0.3),
            const Color(0xFFFFFFFF).withOpacity(0.2),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}

// ---------------- CHAT LIST ITEM ----------------
class _ChatListItem extends StatefulWidget {
  final _ChatPreview chat;
  final bool selected;
  final VoidCallback onTap;

  const _ChatListItem({
    required this.chat,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<_ChatListItem> with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selected) {
      _hoverController.forward();
    } else if (!_isHovering) {
      _hoverController.reverse();
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        if (!widget.selected) _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        if (!widget.selected) _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_hoverController.value * 0.05),
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: widget.selected
                      ? const LinearGradient(
                          colors: [Color(0xFFFFFFFF), Color(0xFFE0E0E0)],
                        )
                      : LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1 * _hoverController.value),
                            Colors.white.withOpacity(0.05 * _hoverController.value),
                          ],
                        ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: widget.selected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFFFFFFF).withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: widget.selected ? Colors.black.withOpacity(0.1) : Colors.white.withOpacity(0.2),
                      child: Icon(
                        Icons.group,
                        color: widget.selected ? Colors.black : Colors.white70,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.chat.title,
                            style: TextStyle(
                              color: widget.selected ? Colors.black : Colors.white70,
                              fontWeight: widget.selected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            widget.chat.lastMessage,
                            style: TextStyle(
                              color: widget.selected ? Colors.black54 : Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- MOBILE CHAT SCREEN ----------------
class ChatScreen extends StatefulWidget {
  final _ChatPreview chat;

  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Animated background gradient
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.5 + (_pulseAnimation.value - 1) * 0.5,
                      colors: [
                        const Color(0xFF1A1A1A).withOpacity(0.6),
                        const Color(0xFF0A0A0F),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // header
                _buildGlassHeader(widget.chat.title),

                const SizedBox(height: 24),

                // messages placeholder
                Expanded(
                  child: _buildGlassCard(
                    child: Center(
                      child: Text(
                        'Üzenetek helye',
                        style: TextStyle(color: AppColors.text(context)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // input
                _buildGlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Üzenet írása...',
                              hintStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widgets (repeated for ChatScreen)
  Widget _buildGlassHeader(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFFFFF).withOpacity(0.3),
            const Color(0xFFFFFFFF).withOpacity(0.2),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}

// ---------------- MODEL (PLACEHOLDER) ----------------
class _ChatPreview {
  final String title;
  final String lastMessage;

  const _ChatPreview({
    required this.title,
    required this.lastMessage,
  });
}