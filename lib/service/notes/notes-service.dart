import 'package:get_storage/get_storage.dart';
import 'package:salamatiman/service/base.dart';
import 'package:salamatiman/utils/get-date.dart';

class NotesService extends BaseService {
  getNotes() async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: "note/records",
      loading: false,
      body: {
        "token": token,
        "start": "2020-6-14",
        "end": GetDate.todayOnlyDate().toString() + "24:59:59"
      },
      hasHeader: true,
      hasToken: true,
    );
    return res;
  }

  getNotesByDate({required date}) async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: "note/records",
      loading: true,
      body: {"token": token, "date": date.toString()},
      hasHeader: true,
      hasToken: true,
    );
    return res;
  }

  setNewNote({required String? content}) async {
    print("sssssssssssssss");
    print(content);
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: "note/addRecord",
      loading: true,
      body: {"token": token, "content": content},
      hasHeader: true,
      hasToken: true,
    );
    return res;
  }

  updateNote({required String? content, required noteID}) async {
    var token = await GetStorage().read('UserToken');
    var res = await BaseService.post(
      path: "note/updateRecord",
      loading: true,
      body: {"token": token, "content": content, "rid": noteID},
      hasHeader: true,
      hasToken: true,
    );
    return res;
  }

  deleteNote({required listDelete}) async {
    List ids = [];
    if (listDelete is int) {
      ids.add(listDelete);
    } else {
      ids = listDelete;
    }
    var token = await GetStorage().read('UserToken');
    return await BaseService.post(
        path: "record/deleteByIds",
        body: {"token": token, "rids": ids},
        loading: true,
        hasToken: true,
        hasHeader: true);
  }
}
