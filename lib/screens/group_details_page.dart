import 'package:flutter/material.dart';

class GroupDetailPage extends StatefulWidget {
  final String groupName;

  const GroupDetailPage({Key? key, required this.groupName}) : super(key: key);

  @override
  _GroupDetailPageState createState() => _GroupDetailPageState();
}

String roleLabel(String role) {
  switch (role) {
    case "admin":
      return "Adminisztrátor";
    case "moderator":
      return "Moderátor";
    default:
      return "Tag";
  }
}

Color roleColor(String role) {
  switch (role) {
    case "admin":
      return Colors.redAccent;
    case "moderator":
      return Colors.orangeAccent;
    default:
      return Colors.white.withOpacity(0.6);
  }
}

class GroupMember {
  final String id;
  final String name;
  final String role; // admin | moderator | member

  GroupMember({
    required this.id,
    required this.name,
    required this.role,
  });
}


class _GroupDetailPageState extends State<GroupDetailPage>
    with TickerProviderStateMixin {

  final List<GroupMember> members = [
  GroupMember(id: "1", name: "Kovács Anna", role: "admin"),
  GroupMember(id: "2", name: "Nagy Péter", role: "moderator"),
  GroupMember(id: "3", name: "Szabó Emma", role: "member"),
  GroupMember(id: "4", name: "Tóth Márk", role: "member"),
  ];

  int selectedIndex = 0;
  int? hoveredIndex;
  final TextEditingController _chatController = TextEditingController();
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    _postController.dispose();
    super.dispose();
  }

  Color getGroupColor() {
    final groupColors = {
      "Matematika": Color(0xFF6366F1),
      "Fizika": Color(0xFF8B5CF6),
      "Informatika": Color(0xFF06B6D4),
      "Biológia": Color(0xFF10B981),
      "Kémia": Color(0xFFF59E0B),
      "Történelem": Color(0xFFEF4444),
    };
    return groupColors[widget.groupName] ?? Color(0xFF6366F1);
  }

  IconData getGroupIcon() {
    final groupIcons = {
      "Matematika": Icons.calculate_rounded,
      "Fizika": Icons.science_rounded,
      "Informatika": Icons.computer_rounded,
      "Biológia": Icons.biotech_rounded,
      "Kémia": Icons.science_outlined,
      "Történelem": Icons.auto_stories_rounded,
    };
    return groupIcons[widget.groupName] ?? Icons.group_rounded;
  }

  Widget navButton(String label, int index, {IconData? icon}) {
    final bool selected = selectedIndex == index;
    final isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: selected ? 1.0 : 0.0),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: selected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.08),
                        ],
                      )
                    : (isHovered
                          ? LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.08),
                                Colors.white.withOpacity(0.04),
                              ],
                            )
                          : null),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(selected ? 0.3 : 0.0),
                  width: 1,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: getGroupColor().withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 0,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: Colors.white.withOpacity(selected ? 0.95 : 0.6),
                      size: 22,
                    ),
                    SizedBox(width: 12),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(selected ? 0.95 : 0.6),
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildNavBar(bool isDesktop) {
    if (isDesktop) {
      return Container(
        width: 180,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F)],
          ),
          border: Border(
            right: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 24),
            navButton("Csevegés", 0, icon: Icons.chat_rounded),
            navButton("Posztok", 1, icon: Icons.article_rounded),
            navButton("Tagok", 2, icon: Icons.people_rounded),
          ],
        ),
      );
    } else {
      return Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F)],
          ),
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              navButton("Chat", 0, icon: Icons.chat_rounded),
              navButton("Bejegyzések", 1, icon: Icons.article_rounded),
              navButton("Tagok", 2, icon: Icons.people_rounded),
            ],
          ),
        ),
      );
    }
  }

  Widget buildChatBubble(String text, bool isMe, String time) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(isMe ? 20 * (1 - value) : -20 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                constraints: BoxConstraints(maxWidth: 300),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            getGroupColor().withOpacity(0.8),
                            getGroupColor().withOpacity(0.6),
                          ],
                        )
                      : null,
                  color: isMe ? null : Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(isMe ? 20 : 4),
                    bottomRight: Radius.circular(isMe ? 4 : 20),
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(isMe ? 0.3 : 0.05),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isMe
                          ? getGroupColor().withOpacity(0.2)
                          : Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPostCard(String author, String content, String time, int likes) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.04),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              getGroupColor().withOpacity(0.8),
                              getGroupColor().withOpacity(0.5),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: getGroupColor().withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            author[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              author,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    content,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite_rounded,
                              size: 16,
                              color: Colors.red.withOpacity(0.8),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "$likes",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.comment_rounded,
                          size: 16,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

Widget buildMembersView() {
  return ListView.builder(
    padding: EdgeInsets.all(16),
    itemCount: members.length,
    itemBuilder: (context, index) {
      final member = members[index];

      return Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 22,
              backgroundColor: getGroupColor().withOpacity(0.8),
              child: Text(
                member.name[0],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(width: 14),

            // Név + rang
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    roleLabel(member.role),
                    style: TextStyle(
                      color: roleColor(member.role),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.3),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildContent() {
  if (selectedIndex == 0) {
    // 💬 CHAT
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            children: [
              buildChatBubble(
                "Sziasztok! Van valakinek a házi feladat megoldása?",
                false,
                "10:23",
              ),
              buildChatBubble("Szia! Igen, küldöm neked.", true, "10:25"),
              buildChatBubble("Köszönöm szépen! 🙏", false, "10:26"),
              buildChatBubble(
                "Nincs mit! Ha kérdésed van, írj bátran.",
                true,
                "10:27",
              ),
            ],
          ),
        ),
        buildInputRow(isChat: true),
      ],
    );
  } else if (selectedIndex == 1) {
    // 📰 POSZTOK
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              buildPostCard(
                "Kovács Anna",
                "Sziasztok! Megosztanám veletek a mai előadás jegyzetét. Aki szeretné, írjon rám!",
                "2 órája",
                12,
              ),
              buildPostCard(
                "Nagy Péter",
                "Holnap lesz az évfolyamdolgozat, sok sikert mindenkinek! 📚",
                "5 órája",
                24,
              ),
              buildPostCard(
                "Szabó Emma",
                "Találtam egy nagyon jó videót a témához, érdemes megnézni!",
                "1 napja",
                8,
              ),
            ],
          ),
        ),
        buildInputRow(isChat: false),
      ],
    );
  } else if (selectedIndex == 2) {
    // 👥 TAGOK
    return buildMembersView();
  }

  // fallback (biztonsági)
  return SizedBox.shrink();
}

  Widget buildInputRow({required bool isChat}) {
    final controller = isChat ? _chatController : _postController;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F)],
        ),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            margin: EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  getGroupColor().withOpacity(0.8),
                  getGroupColor().withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: getGroupColor().withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () async {},
                child: Center(
                  child: Icon(
                    Icons.image_rounded,
                    color: Colors.white.withOpacity(0.9),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                maxLines: isChat ? 1 : null,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: isChat
                      ? "Írj üzenetet..."
                      : "Írj egy bejegyzést...",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
          ),

          SizedBox(width: 12),

          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  getGroupColor().withOpacity(0.8),
                  getGroupColor().withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: getGroupColor().withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {},
                child: Center(
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white.withOpacity(0.9),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 800;
    final groupColor = getGroupColor();

    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0F0F0F),
        elevation: 0,
        leadingWidth: 40,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white.withOpacity(0.9),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    groupColor.withOpacity(0.8),
                    groupColor.withOpacity(0.5),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: groupColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(getGroupIcon(), color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Text(
              widget.groupName,
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A0A), Color(0xFF121212)],
          ),
        ),
        child: isDesktop
            ? Row(
                children: [
                  buildNavBar(true),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0.02, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        key: ValueKey(selectedIndex),
                        child: buildContent(),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Container(
                        key: ValueKey(selectedIndex),
                        child: buildContent(),
                      ),
                    ),
                  ),
                  buildNavBar(false),
                ],
              ),
      ),
    );
  }
}