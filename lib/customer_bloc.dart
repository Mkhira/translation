


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/customer_state.dart';
import 'package:path_provider/path_provider.dart';

import 'data_provider.dart';

class CustomerCubit extends Cubit<CustomerState>{
  CustomerCubit() : super(CustomerStateInitial());
  static CustomerCubit get(BuildContext context) => BlocProvider.of(context);
  Future<void> getCustomers() async{
    emit(CustomerStateLoading());
    Response? response  = await DataProvider.get();

    if(response.statusCode ==200){
      response.data['Customers'][0].forEach((i,v){
       if(v == null){
         response.data['Customers'][0].update(i, (value) => "ffff");
       }
      });
      saveFile(jsonEncode(response.data['Customers'][0]),'en-US');
     readFile('en-US');

      response.data['Customers'][0].forEach((i,v){
        if(v == "ffff"){
          response.data['Customers'][0].update(i, (value) => "اهلا وسهلا");
        }
      });
      saveFile(jsonEncode(response.data['Customers'][0]),'ar-AR');
      readFile('ar-AR');
      emit(CustomerStateSuccess());
    }else{
      emit(CustomerStateFail());
    }
  }
  Future<String>  localPath(String name) async {
    final directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$name.json'; // 3

    print(directory.uri);
    print(directory.isAbsolute);
    print(directory.parent.absolute.path);
    print(directory.parent.statSync().type);
    print(filePath);
    return filePath;
  }
  void saveFile(String data,String name) async {
    File file = File(await localPath(name)); // 1
    file.writeAsString(data); // 2
  }

  void readFile(String name) async {
    File file = File(await localPath(name)); // 1
    String fileContent = await file.readAsString(); // 2

    print('File Content: $fileContent');
  }
}