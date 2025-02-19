import 'package:flutter/material.dart';
import 'package:product_firestore_app/service/database.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Database.myInstance;
    var myStream = db.getAllProductStream();    
    
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: myStream, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('ยังไม่มีข้อมูลสินค้า', 
            style: TextStyle(fontSize: 24),));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    db.deleteProduct(product: snapshot.data![index]);
                  }
                },
                direction: DismissDirection.endToStart,
                background: Container(color: const Color.fromARGB(255, 255, 17, 0)),
                child: ListTile(
                  title: Text(snapshot.data![index].productName),
                  subtitle: Text('฿${snapshot.data![index].price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.do_not_disturb_on_total_silence_outlined, color: Color.fromARGB(255, 255, 17, 0), size: 28),
                    onPressed: () {
                      db.deleteProduct(product: snapshot.data![index]);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}