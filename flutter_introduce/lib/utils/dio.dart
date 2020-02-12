/*
 * dio HTTP
 * Created by wang_ke
 */


// import 'dart:io';

// import 'package:dio/dio.dart';

// const serviceUrl = "http://ex.gaiafintech.com:4101";

// const servicePath = {
//   'getNotice' : serviceUrl + "/bulletin/getallrelease", //获取公告信息
//   'userlogin' : serviceUrl + "/userloginservice/userlogin", //登录
//   'register' : serviceUrl + "/userregisterservice/registeruser", //注册
// };

// Future httpGet(url, {params}) async{
//   try{
//     print("=============================  GET开始请求数据");
//     print("=============================  url: ${servicePath[url]}");
//     print("=============================  params: $params");
//     Response response;
//     Dio dio = Dio();
//     dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded") as String;
//     if(params == null){
//       response = await dio.get(servicePath[url]);
//     }else{
//       response = await dio.get(servicePath[url], queryParameters: params);
//     }
//     if(response.statusCode == 200){
//       return response.data;
//     }else{
//       throw Exception("GET接口异常，请检查接口路径是否存在或正确！");
//     }
//   }catch(e){
//     return print("GET请求异常，错误信息: =======> $e");
//   }
// }

// Future httpPost(url, {params}) async{
//   try{
//     print("=============================  POST开始请求数据");
//     print("=============================  url: ${servicePath[url]}");
//     print("=============================  params: $params");
//     Response response;
//     Dio dio = Dio();
//     dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded") as String;
//     if(params == null){
//       response = await dio.post(servicePath[url]);
//     }else{
//       response = await dio.post(servicePath[url], data: params);
//     }
//     if(response.statusCode == 200){
//       return response.data;
//     }else{
//       throw Exception("POST接口异常，请检查接口路径是否存在或正确！");
//     }
//   }catch(e){
//     return print("POST请求异常，错误信息: =======> $e");
//   }
// }

// //使用方法
// void getData() async{
//   var data = {
//     '参数名' : '参数值'
//   };
//   await httpPost('getNotice', params: data).then((result){

//   });
// }