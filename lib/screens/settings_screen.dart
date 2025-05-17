import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: Column(
        children: [
          // Cabeçalho
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            color: const Color(0xFF8BC34A),
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.local_florist, color: Colors.white, size: 32),
                SizedBox(height: 8),
                Text(
                  'Smart Garden',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Seção título
          Container(
            width: double.infinity,
            color: const Color(0xFFC8E6C9),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

