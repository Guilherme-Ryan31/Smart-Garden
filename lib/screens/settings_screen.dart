import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
            Container(
            width: double.infinity,
            color: const Color(0xFFA0C85E),
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                Image.asset('assets/logo2.png', height: 32, width: 32),
                const SizedBox(width: 8),
                const Text(
                  'Smart Garden',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
          width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFD2E8C9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32), 
                ),
            ),
              child: const Text(
              'Configurações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
              
          ),

          // Itens da lista
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                sectionTitle('Perfil'),
                settingsTile('Editar nome e foto'),

                sectionTitle('Notificações'),
                settingsTile('Alertas de plantas'),
                settingsTile('Configurar notificações'),

                sectionTitle('Preferências do app'),
                settingsTile('Tema'),
                settingsTile('Idioma'),

                sectionTitle('Conexões'),
                settingsTile('Sensores vinculados'),
                settingsTile('Permissões de acesso', subtitle: 'Privacidade e segurança'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget settingsTile(String title, {String? subtitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFD0F0C0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
