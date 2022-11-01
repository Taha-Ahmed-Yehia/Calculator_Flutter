import 'package:calculator_app/ThemeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationManager{
  static final instance = ApplicationManager();
  late AppTheme theme = DarkAppTheme();
  AnAction onThemeChangeAction = AnAction();
  bool isInitialized = false;
  bool lightTheme = false;
  init(){
    instance.loadData();
  }
  void saveData() async {
    print("Saving Data...");
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userPref.clear();
    userPref.setBool("lightMode", lightTheme);
    userPref.reload();
    print("Saved Data: ${userPref.getKeys().length}");
    isInitialized = true;
  }
  void loadData() async {
    print("Loading Data....");
    SharedPreferences userPref = await SharedPreferences.getInstance();
    userPref.reload();
    if(userPref.getKeys().isEmpty){
      instance.saveData();
    }
    else{
      //-------Debug------
      print("Loaded Data: ${userPref.getKeys().toString()}");
      List<String> keys = userPref.getKeys().toList();
      for(int i = 0; i < keys.length; i++){
        print("${keys[i].toString()}: ${userPref.get(keys[i])}");
      }
      //-------------------

      final isLight = userPref.getBool("lightMode")?? false;
      if (isLight) {
        lightTheme = true;
        theme = LightAppTheme();
      }
      isInitialized = true;
      onThemeChangeAction.invoke();
    }
  }
}

//a class for putting methods in list and fire it when you needed
class AnAction {
  final List<Function> _functions = List.empty(growable: true);

  void addAction(Function func) {
    if(!_functions.contains((func))) {
      _functions.add(func);
    }
  }

  void removeAction(Function func) {
    _functions.remove(func);
  }

  void invoke() {
    for (Function func in _functions) {
      func.call();
    }
  }
}
