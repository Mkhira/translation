import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:localization/customer_bloc.dart';
import 'package:path_provider/path_provider.dart';

final locator = GetIt.instance;


void setup()async{

   locator.registerSingleton<CustomerCubit>( CustomerCubit());


   locator.registerSingletonAsync<languageCheck>(() async{
     languageCheck x = languageCheck();
     await x.checkLanguage();
     return x;
   });

}

class languageCheck{
  languageCheck():super(){
    checkLanguage();
  }
  Future<bool> checkLanguage()async{
    final directory = await getApplicationDocumentsDirectory();

    File file = File( '${directory.path}/en-US.json');

    if(!await file.exists()){
     await locator.get<CustomerCubit>().getCustomers();

      return true;
    }else{


      return true;
    }

  }


}

