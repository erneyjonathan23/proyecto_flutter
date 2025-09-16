import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/address.dart';
import '../providers/user_provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _country = 'Colombia';
  String? _department;
  String? _city;
  String? _details;

  final List<String> _departments = ['Antioquia', 'Cundinamarca', 'Valle del Cauca'];
  final Map<String, List<String>> _cities = {
    'Antioquia': ['Medellín', 'Envigado', 'Bello'],
    'Cundinamarca': ['Bogotá', 'Soacha'],
    'Valle del Cauca': ['Cali', 'Palmira'],
  };

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Dirección')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _country,
                decoration: const InputDecoration(labelText: 'País'),
                items: [DropdownMenuItem(value: 'Colombia', child: Text('Colombia'))],
                onChanged: (value) => setState(() => _country = value),
              ),
              DropdownButtonFormField<String>(
                value: _department,
                decoration: const InputDecoration(labelText: 'Departamento'),
                items: _departments.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (value) => setState(() {
                  _department = value;
                  _city = null;
                }),
                validator: (value) => value == null ? 'Campo requerido' : null,
              ),
              DropdownButtonFormField<String>(
                value: _city,
                decoration: const InputDecoration(labelText: 'Municipio'),
                items: (_department != null ? _cities[_department!] ?? <String>[] : <String>[]) 
                    .map<DropdownMenuItem<String>>((c) => DropdownMenuItem<String>(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => setState(() => _city = value),
                validator: (value) => value == null ? 'Campo requerido' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dirección física detallada'),
                onSaved: (value) => _details = value,
                validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              const Text('Mis Direcciones', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView(
                  children: userProvider.user?.addresses.map((address) => ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text('${address.details}'),
                    subtitle: Text('${address.city}, ${address.department}, ${address.country}'),
                  )).toList() ?? [],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final address = Address(
                            country: _country!,
                            department: _department!,
                            city: _city!,
                            details: _details!,
                          );
                          userProvider.addAddress(address);
                          setState(() {
                            _department = null;
                            _city = null;
                            _details = null;
                          });
                        }
                      },
                      child: const Text('Agregar Dirección'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Volver'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/user-detail');
                      },
                      child: const Text('Finalizar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
