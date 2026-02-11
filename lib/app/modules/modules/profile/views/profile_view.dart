import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller secara manual jika tidak melalui GetPage binding
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Profil Saya",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // 1. HEADER PROFIL (FOTO & INFORMASI UTAMA)
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFFFC107), width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 55,
                          backgroundColor: Color(0xFF1A1A1A),
                          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1974&auto=format&fit=crop'),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFC107),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt_rounded, size: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(() => Text(
                        controller.userName.value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(height: 6),
                  Obx(() => Text(
                        controller.userEmail.value,
                        style: const TextStyle(color: Colors.white54, fontSize: 14),
                      )),
                  const SizedBox(height: 16),
                  // Lencana Status Member
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFFC107).withOpacity(0.4)),
                    ),
                    child: Obx(() => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_rounded, color: Color(0xFFFFC107), size: 16),
                        const SizedBox(width: 8),
                        Text(
                          controller.memberStatus.value.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFFFFC107), 
                            fontSize: 12, 
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 2. KARTU STATISTIK (POIN & TIKET)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem("Poin CineGo", controller.points.value.toString(), Icons.stars_rounded),
                    Container(width: 1, height: 45, color: Colors.white10),
                    _buildStatItem("Total Tiket", controller.ticketCount.value.toString(), Icons.confirmation_num_rounded),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 3. MENU PENGATURAN & INFORMASI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PENGATURAN AKUN",
                    style: TextStyle(
                      color: Colors.white38, 
                      fontSize: 12, 
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(Icons.person_outline_rounded, "Informasi Pribadi"),
                  _buildMenuItem(Icons.history_rounded, "Riwayat Transaksi"),
                  _buildMenuItem(Icons.payment_rounded, "Metode Pembayaran"),
                  _buildMenuItem(Icons.notifications_none_rounded, "Notifikasi"),
                  
                  const SizedBox(height: 24),
                  const Text(
                    "DUKUNGAN & LAINNYA",
                    style: TextStyle(
                      color: Colors.white38, 
                      fontSize: 12, 
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(Icons.help_outline_rounded, "Pusat Bantuan"),
                  _buildMenuItem(Icons.privacy_tip_outlined, "Kebijakan Privasi"),
                  _buildMenuItem(Icons.info_outline_rounded, "Tentang CineGo"),
                  
                  const SizedBox(height: 12),
                  // Tombol Keluar
                  _buildMenuItem(
                    Icons.logout_rounded,
                    "Keluar",
                    textColor: Colors.redAccent,
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // Widget pendukung untuk item statistik
  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFFFC107), size: 28),
        const SizedBox(height: 8),
        Text(
          value, 
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  // Widget pendukung untuk item menu list
  Widget _buildMenuItem(IconData icon, String title, {Color textColor = Colors.white, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap ?? () {},
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        hoverColor: Colors.white.withOpacity(0.05),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: textColor == Colors.redAccent 
                ? Colors.redAccent.withOpacity(0.1) 
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: textColor, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: textColor == Colors.redAccent 
            ? null 
            : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
      ),
    );
  }

  // Dialog konfirmasi logout menggunakan GetX
  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "Konfirmasi Keluar", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        content: const Text(
          "Apakah Anda yakin ingin mengakhiri sesi dan keluar dari CineGo?", 
          style: TextStyle(color: Colors.white70)
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("BATAL", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () => controller.logout(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              "YA, KELUAR", 
              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }
}
