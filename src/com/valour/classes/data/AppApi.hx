package com.valour.classes.data;

import com.metropolis.Request;

class AppApi {
    
    public static var authenticateApp:Request = new Request(
        "mutation authenticateApp($pkgName: String!) {\n  authenticateApp(pkgName: $pkgName) {\n    token\n  }\n}\n",
        {"pkgName":"del.del.del"},
        "authenticateApp"
    );


}