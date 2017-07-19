package 
{
	
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.async.Async;
	import org.flexunit.Assert;
	import org.flexunit.runner.FlexUnitCore;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	
	import fin.desktop.ExternalWindow;
	import fin.desktop.InterApplicationBus;
	import fin.desktop.RuntimeConfiguration;
	import fin.desktop.RuntimeLauncher;
	import fin.desktop.Window;
	import fin.desktop.Application;
	import fin.desktop.ApplicationOptions;
	import fin.desktop.WindowOptions;
	import fin.desktop.connection.DesktopConnection;
	
	
	public class TestRunner extends Sprite
	{
		private var runtimeLauncher:RuntimeLauncher;
		
		public function TestRunner() 
		{
			RuntimeConfiguration.enableTraceLogging(); // enable logging from AirAdapter to trace()
			RuntimeConfiguration.enableFileLogging("air-adapter-example.log"); // enable file logging from AirAdapter to %LocalAppData/Openfin/logs/
			var cfg:RuntimeConfiguration = new RuntimeConfiguration("inter-app-messenger");
			cfg.appManifestUrl = "https://demoappdirectory.openf.in/desktop/config/apps/OpenFin/HelloOpenFin/app.json";
			
			
			var eventHandler:Function = function():void
			{
				trace("runtime connection ready");
				
				var core : FlexUnitCore = new FlexUnitCore();
				
				core.addListener( new TraceListener() );
				core.addListener(new CIListener());
				
				core.run(ApplicationTest, WindowTest, InterApplicationBusTest);
			}
			
			cfg.onConnectionReady = eventHandler;
			cfg.onConnectionError = function (level:String):void 
			{
				trace("RuntimeConfiguration.onConnectionError:" + level);
			}
			
			cfg.connectionTimeout = 10000;  // milli-seconds
			runtimeLauncher = new RuntimeLauncher(cfg);
		}
		
	}

}