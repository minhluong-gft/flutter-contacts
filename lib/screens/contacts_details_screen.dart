import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;
  const ContactDetailsScreen(this.contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.star_outline))
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image(
                image: contact.avatar != null
                    ? NetworkImage(contact.avatar!)
                    : const AssetImage('assets/images/default_avatar.jpg')
                        as ImageProvider,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                height: 200,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      contact.fullName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            contact.email,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
          )
        ],
      ),
    );
  }
}
