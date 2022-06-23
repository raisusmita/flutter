import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class MyFormPage extends StatefulWidget {
  const MyFormPage({Key? key}) : super(key: key);

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  TextEditingController tenantFieldController = TextEditingController();
  TextEditingController aliasFieldController = TextEditingController();
  String tenant = "";
  String alias = "";
  String apiUrl = "zenoplemasterapi.aqore.com";

  @override
  Widget build(BuildContext context) {
    tenantFieldController.text = "ZenopleMaster";
    aliasFieldController.text = "aaa";

    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
        centerTitle: true,
      ),
      body: Center(
        child: _myFormWidget(),
      ),
    );
  }

  Widget _tenantFieldWidget() {
    return TextFormField(
        controller: tenantFieldController,
        onFieldSubmitted: (value) {
          tenant = value;
        },
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value!.isEmpty) {
            return 'this is required field';
          }
          return null;
        });
  }

  Widget _aliasFieldWidget() {
    return TextFormField(
        controller: aliasFieldController,
        onFieldSubmitted: (value) {
          alias = value;
          print(alias);
        },
        // keyboardType: TeaaaxtInputType.number,
        validator: (value) {
          if (value == null || value!.isEmpty) {
            return 'this is required field';
          }
          return null;
        });
  }

  Widget _applyButton() {
    return ElevatedButton(
        onPressed: () {
          print(alias);
          if (myFormKey.currentState!.validate()) {
            getOrganization(alias);
          }
        },
        child: Text('Apply'));
  }

  getOrganization(alias) async {
    final params = jsonEncode({'alias':"aaa"});
    Uri url =
        Uri.https(apiUrl, '/api/organization/tenantOrganization', {'json': params});
    // Uri url =
    //     Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  Widget _myFormWidget() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: myFormKey,
          child: Column(children: [
            Text('Tenant'),
            _tenantFieldWidget(),
            Text('Alias'),
            _aliasFieldWidget(),
            _applyButton()
          ]),
        ));
  }
}
