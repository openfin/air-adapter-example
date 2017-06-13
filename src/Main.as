package {

import fin.desktop.ExternalWindow;
import fin.desktop.InterApplicationBus;
import fin.desktop.RuntimeConfiguration;
import fin.desktop.RuntimeLauncher;
import fin.desktop.Window;
import fin.desktop.connection.DesktopConnection;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class Main extends Sprite {

    var runtimeLauncher: RuntimeLauncher;

    public function Main() {

        RuntimeConfiguration.enableTraceLogging(); // enable logging from AirAdapter to trace()
        RuntimeConfiguration.enableFileLogging("air-adapter-example.log"); // enable file logging from AirAdapter to %LocalAppData/Openfin/logs/
        var cfg:RuntimeConfiguration = new RuntimeConfiguration("inter-app-messenger");
        cfg.appManifestUrl = "https://demoappdirectory.openf.in/desktop/config/apps/OpenFin/HelloOpenFin/app.json";
        cfg.onConnectionReady = onConnectionReady;
        cfg.onConnectionError = onConnectionError;
        cfg.onConnectionClose = onConnectionClose;
        cfg.connectionTimeout = 15000;  // milli-seconds
        // cfg.runtimeInstallPath = "c:\\openfin";  // override OpenFin Runtime default install directory (%LocalAppData/Openfin)
        runtimeLauncher = new RuntimeLauncher(cfg);
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

    private function onConnectionError(reason: String) {
        trace("Connection failed", reason);
    }
    private function onConnectionClose(reason:String = null):void {
        trace("Connection close", reason);
    }

}
}
