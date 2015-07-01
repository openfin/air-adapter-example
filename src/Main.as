package {

import fin.desktop.ExternalWindow;
import fin.desktop.InterApplicationBus;
import fin.desktop.RuntimeLauncher;
import fin.desktop.System;
import fin.desktop.Window;
import fin.desktop.connection.DesktopConnection;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class Main extends Sprite {

    var connection: DesktopConnection;

    public function Main() {

        connection = new DesktopConnection("inter-app-messenger", "localhost", "9696" , onConnectionReady);
       // new RuntimeLauncher("AppData\\Local\\OpenFin\\OpenFinRVM.exe", "http://openfin.github.io/excel-api-example/app.json", onConnectionReady);
    }

    private function onConnectionReady(): void{

        trace("Connection Successful!");
        var timer: Timer = new Timer(1000);
        timer.addEventListener(TimerEvent.TIMER, onTimer);
        timer.start();

        var exWindow: ExternalWindow = new ExternalWindow(stage.nativeWindow, "grid", "interapp-air");
        var gridWindow: Window = new Window("grid", "grid");
        exWindow.joinGroup(gridWindow);

    }

    private function onTimer(event: TimerEvent): void{

        InterApplicationBus.getInstance().publish("test", {value: "test"});
    }



}
}
