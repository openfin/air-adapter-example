package {

import fin.desktop.RuntimeLauncher;
import fin.desktop.System;
import fin.desktop.connection.DesktopConnection;
import flash.display.Sprite;

public class Main extends Sprite {

    var connection: DesktopConnection;

    public function Main() {

       // connection = new DesktopConnection("OpenFinJSAPITestBench", "localhost", "9696" , onConnectionReady);
        new RuntimeLauncher("AppData\\Local\\OpenFin\\OpenFinRVM.exe", "http://openfin.github.io/excel-api-example/app.json", onConnectionReady);
    }

    private function onConnectionReady(): void{

        trace("Connection Successful!");
    }


}
}
