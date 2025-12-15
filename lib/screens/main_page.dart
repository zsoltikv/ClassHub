import 'package:flutter/material.dart';
import 'package:classhubweb/screens/groups_page.dart';
import 'messages_page.dart';
import 'login_page.dart';
import 'events_page.dart';
import '../theme/app_colors.dart';
import 'dart:ui';

enum ProfileOption {
  settings,
  theme,
  logout,
}

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreen();
}

class _MainPageScreen extends State<MainPageScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  ProfileOption? _selectedProfileOption;
  bool _profileMenuOpen = false;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;

  final List<Widget> _pages = const [
    GroupsPage(),
    MessagesPage(),
    EventsPage(),
    Center(child: Text('Osztálykirándulás tervező')),
  ];

  bool get isDesktop => MediaQuery.of(context).size.width >= 900;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 4) _profileMenuOpen = false;
    });
    _slideController.forward(from: 0);
  }

  Widget _buildSettingsPage(BuildContext context) {
    bool notifications = true;

    return StatefulBuilder(
      builder: (context, setLocalState) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGlassHeader('Beállítások'),
              const SizedBox(height: 24),

              _buildGlassCard(
                child: Column(
                  children: [
                    _buildGlassTile(
                      title: 'Értesítések',
                      trailing: Switch(
                        value: notifications,
                        onChanged: (val) => setLocalState(() => notifications = val),
                        activeColor: const Color(0xFFFFFFFF),
                      ),
                    ),
                    _buildDivider(),
                    _buildGlassTile(
                      title: 'Jelszó módosítása',
                      icon: Icons.lock_outline,
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildGlassTile(
                      title: 'Profilkép módosítása',
                      icon: Icons.image_outlined,
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildGlassTile(
                      title: 'Felhasználónév módosítása',
                      icon: Icons.person_outline,
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildGlassTile(
                      title: 'Profil törlése',
                      icon: Icons.delete_outline,
                      onTap: () {},
                      isDestructive: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeSelectionPage(BuildContext context) {
    final List<Map<String, dynamic>> themes = [
      {'name': 'Világos', 'color': const Color(0xFFFFFFFF), 'gradient': [const Color(0xFFE0E0E0), const Color(0xFFFFFFFF)]},
      {'name': 'Sötét', 'color': const Color(0xFF1A1A1A), 'gradient': [const Color(0xFF000000), const Color(0xFF2A2A2A)]},
      {'name': 'Kék', 'color': const Color(0xFF2196F3), 'gradient': [const Color(0xFF1565C0), const Color(0xFF42A5F5)]},
      {'name': 'Piros', 'color': const Color(0xFFE53935), 'gradient': [const Color(0xFFC62828), const Color(0xFFEF5350)]},
      {'name': 'Zöld', 'color': const Color(0xFF43A047), 'gradient': [const Color(0xFF2E7D32), const Color(0xFF66BB6A)]},
      {'name': 'Lila', 'color': const Color(0xFF8E24AA), 'gradient': [const Color(0xFF6A1B9A), const Color(0xFFAB47BC)]},
      {'name': 'Narancs', 'color': const Color(0xFFFB8C00), 'gradient': [const Color(0xFFE65100), const Color(0xFFFFB74D)]},
      {'name': 'Sárga', 'color': const Color(0xFFFDD835), 'gradient': [const Color(0xFFF9A825), const Color(0xFFFFEB3B)]},
      {'name': 'Rózsaszín', 'color': const Color(0xFFEC407A), 'gradient': [const Color(0xFFC2185B), const Color(0xFFF06292)]},
      {'name': 'Türkiz', 'color': const Color(0xFF00ACC1), 'gradient': [const Color(0xFF00838F), const Color(0xFF26C6DA)]},
    ];

    Color? _selectedColor;

    return StatefulBuilder(
      builder: (context, setLocalState) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGlassHeader('Téma választás'),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: themes.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Map<String, dynamic> theme = entry.value;
                  bool isSelected = _selectedColor == theme['color'];
                  
                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 300 + (idx * 50)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: GestureDetector(
                          onTap: () {
                            setLocalState(() => _selectedColor = theme['color']);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: theme['gradient'],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? Border.all(color: Colors.white, width: 3)
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: (theme['color'] as Color).withOpacity(0.4),
                                  blurRadius: isSelected ? 20 : 10,
                                  spreadRadius: isSelected ? 2 : 0,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                if (isSelected)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Color(0xFFFFFFFF),
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                Center(
                                  child: Text(
                                    theme['name'],
                                    style: TextStyle(
                                      color: (theme['color'] as Color).computeLuminance() > 0.5
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileContent(BuildContext context) {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 400),
    child: Container(
      key: ValueKey(_selectedProfileOption),
      child: () {
        switch (_selectedProfileOption) {
          case ProfileOption.settings:
            return _buildSettingsPage(context);
          case ProfileOption.theme:
            return _buildThemeSelectionPage(context);
          case ProfileOption.logout:
            return Center(
              child: Text('Kijelentkezés...', style: TextStyle(color: AppColors.text(context))),
            );
          default:
            return Center(
              child: Text(
                'Válassz egy opciót a popupból',
                style: TextStyle(color: AppColors.text(context), fontSize: 16),
              ),
            );
        }
      }(),
    ),
  );
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
          Row(
            children: [
              if (isDesktop) _buildSidebar(context),
              Expanded(
                child: SafeArea(
                  child: _selectedIndex != 4
                      ? _pages[_selectedIndex]  // ha nem profil, akkor a 4 fő oldal
                      : _buildProfileContent(context),  // ha profil, akkor a választott profil oldal
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : _buildBottomNav(context),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 125,
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
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 8),
                  _SidebarItem(
                    icon: Icons.home_rounded,
                    label: 'Csoportok',
                    selected: _selectedIndex == 0,
                    onTap: () => _onItemTapped(0),
                    isDesktop: isDesktop,
                  ),
                  _SidebarItem(
                    icon: Icons.chat_bubble_rounded,
                    label: 'Üzenetek',
                    selected: _selectedIndex == 1,
                    onTap: () => _onItemTapped(1),
                    isDesktop: isDesktop,
                  ),
                  _SidebarItem(
                    icon: Icons.event_rounded,
                    label: 'Események',
                    selected: _selectedIndex == 2,
                    onTap: () => _onItemTapped(2),
                    isDesktop: isDesktop,
                  ),
                  _SidebarItem(
                    icon: Icons.directions_bus_rounded,
                    label: 'Kirándulás',
                    selected: _selectedIndex == 3,
                    onTap: () => _onItemTapped(3),
                    isDesktop: isDesktop,
                  ),
                  const Spacer(),
                  _SidebarItem(
                    icon: Icons.person_rounded,
                    label: 'Profil',
                    selected: _selectedIndex == 4,
                    isDesktop: isDesktop,
                    onTap: () {
                      setState(() {
                        _profileMenuOpen = !_profileMenuOpen; // itt nyitjuk/zárjuk a popupot
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                ],
              ),

              // <-- ide jön a popup
              if (_profileMenuOpen)
                Positioned(
                  bottom: 75,
                  left: 12,
                  right: 12,
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 300),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.08),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Column(
                            children: [
                              _ProfileMenuItem(
                                icon: Icons.settings_rounded,
                                onTap: () {
                                  setState(() {
                                    _selectedProfileOption = ProfileOption.settings;
                                    _profileMenuOpen = false;
                                    _selectedIndex = 4;
                                  });
                                },
                              ),
                              Divider(color: Colors.white.withOpacity(0.1), height: 1),
                              _ProfileMenuItem(
                                icon: Icons.palette_rounded,
                                onTap: () {
                                  setState(() {
                                    _selectedProfileOption = ProfileOption.theme;
                                    _profileMenuOpen = false;
                                    _selectedIndex = 4;
                                  });
                                },
                              ),
                              Divider(color: Colors.white.withOpacity(0.1), height: 1),
                              _ProfileMenuItem(
                                icon: Icons.logout_rounded,
                                onTap: () {
                                  setState(() {
                                    _selectedProfileOption = ProfileOption.logout;
                                    _profileMenuOpen = false;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPageScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: const Color(0xFFFFFFFF),
            unselectedItemColor: Colors.white60,
            elevation: 0,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            showUnselectedLabels: false,  // This hides the labels for unselected items
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Csoportok'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_rounded), label: 'Üzenetek'),
              BottomNavigationBarItem(icon: Icon(Icons.event_rounded), label: 'Események'),
              BottomNavigationBarItem(icon: Icon(Icons.directions_bus_rounded), label: 'Kirándulás'),
              BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildGlassTile({
    required String title,
    IconData? icon,
    Widget? trailing,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: isDestructive ? Colors.redAccent : Colors.white70,
                  size: 24,
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDestructive ? Colors.redAccent : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (trailing != null)
                trailing
              else if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.white38,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.1),
      height: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isDesktop; // új paraméter

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.isDesktop, // kötelező legyen
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> with SingleTickerProviderStateMixin {
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      color: widget.selected ? Colors.black : Colors.white70,
                      size: 26,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        color: widget.selected ? Colors.black : Colors.white70,
                        fontWeight: widget.selected ? FontWeight.bold : FontWeight.w500,
                        fontSize: 11,
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

class _ProfileMenuItem extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.onTap,
  });

  @override
  State<_ProfileMenuItem> createState() => _ProfileMenuItemState();
}

class _ProfileMenuItemState extends State<_ProfileMenuItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _isHovering ? Colors.white.withOpacity(0.1) : Colors.transparent,
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: Colors.white70,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}