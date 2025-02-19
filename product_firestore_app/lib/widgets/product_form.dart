import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/service/database.dart';

// ignore: must_be_immutable
class ProductForm extends StatefulWidget {
  ProductModel? product;
  ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  Database db = Database.myInstance;
  var nameController = TextEditingController();
  var priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.product != null){
      nameController.text = widget.product!.productName;
      priceController.text = widget.product!.price.toString();
    }
  }
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.product == null ? 'เพิ่มสินค้า' : 'เเก้ไข ${widget.product!.productName}', style: const TextStyle(color: Colors.white, fontSize: 24),),
        TextField(
          controller: nameController,
          keyboardType: TextInputType.text ,style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(labelText: 'ชื่อสินค้า', labelStyle: TextStyle(color: Colors.white)),
        ),
        TextField(
          controller: priceController,
          keyboardType: TextInputType.text ,style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(labelText: 'ราคาสินค้า', labelStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showBtnOk(context),
            const SizedBox(width: 10,),
            showBtnCancel(context)
          ],
          )
      ],
    );
  }
  Widget showBtnOk(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
      ),
      onPressed: () async{
        String newId = 'PD${DateTime.now().microsecondsSinceEpoch.toString()}';
        await db.setProduct(
          product: ProductModel(
            id: widget.product == null ? newId : widget.product!.id,
            productName: nameController.text, 
            price: double.tryParse(priceController.text) ?? 0, 
            )
          );
        nameController.clear();
        priceController.clear();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }, 
      child: const Text('เพิ่ม', style: TextStyle(color: Colors.white)),
    );
  }

  Widget showBtnCancel(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellowAccent
      ),
      onPressed: (){
        Navigator.of(context).pop();
      }, 
      child: const Text('ปิด')
    );
  }
}
