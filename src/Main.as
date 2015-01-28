package {

import fin.desktop.System;
import fin.desktop.connection.DesktopConnection;

import flash.display.Sprite;
import flash.text.TextField;

public class Main extends Sprite {

    var connection: DesktopConnection;

    public function Main() {

        connection = new DesktopConnection("OpenFinJSAPITestBench", "localhost", "9696" , onConnectionReady, onConnectionError);
    }

    private function onConnectionReady(): void{

        trace("Connection Successful!");
        System.getInstance().getVersion(getVersionCallback, getVersionErrorCallback);
    }

    private function getVersionCallback(version: String): void{

        trace("version is: ", version);
    }

    private function getVersionErrorCallback(reason: String): void{

        trace("Could not retrieve version:", reason);
    }

    private function onConnectionError(reasonse: String): void{

        trace("Could not connect:", reasonse);
    }
}
}
