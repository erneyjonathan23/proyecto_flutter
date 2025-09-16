import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/address.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalles del Usuario')),
        body: const Center(child: Text('No hay usuario registrado.')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles del Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  child: Text(
                    user.firstName.isNotEmpty ? user.firstName[0] : '',
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.firstName} ${user.lastName}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('${_calculateAge(user.birthDate)} años'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Información Personal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Card(
              child: ListTile(
                leading: const Icon(Icons.cake),
                title: Text('Fecha de Nacimiento: ${_formatDate(user.birthDate)}'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text('Género: ${user.gender}'),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Mis Direcciones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ...user.addresses.map((address) => Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(address.details),
                subtitle: Text('${address.city}, ${address.department}, ${address.country}'),
              ),
            )),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navegar a pantalla de edición
                    },
                    child: const Text('Editar Usuario'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/add-address');
                    },
                    child: const Text('Añadir otra Dirección'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
