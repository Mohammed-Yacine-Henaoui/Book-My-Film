import 'package:flutter/material.dart';

Widget FailledGetAllCitiesStateWidget(BuildContext context,void Function()? retry){
  return Center(
              child: ElevatedButton.icon(
                onPressed: retry,
                label: const Text("Retry",style: TextStyle(color: Colors.black),),
                icon: const Icon(Icons.refresh_rounded,color: Colors.black,),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                
              ),
            );
}