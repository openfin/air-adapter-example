package test
{
	import com.hurlant.util.der.Integer;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flexunit.framework.Test;
	import org.flexunit.async.Async;
	import org.flexunit.Assert;
	
	import fin.desktop.ExternalWindow;
	import fin.desktop.InterApplicationBus;
	import fin.desktop.RuntimeConfiguration;
	import fin.desktop.RuntimeLauncher;
	import fin.desktop.Window;
	import fin.desktop.Application;
	import fin.desktop.ApplicationOptions;
	import fin.desktop.WindowOptions;
	import fin.desktop.connection.DesktopConnection;
	
	public class WindowTest
	{
		private static var app:Application;
		
		[BeforeClass(async)]
		public static function createApplication():void
		{
			trace("WindowTest: create application");
			var applicationOptions:ApplicationOptions = new ApplicationOptions("windowTest", "https://www.google.com");
			var windowOptions:WindowOptions = new WindowOptions();
			windowOptions.minimizable = true;
			windowOptions.maximizable = true;
			windowOptions.autoShow = true;
			windowOptions.showTaskbarIcon = true;
			windowOptions.frame = true;
			windowOptions.defaultWidth = 640;
			windowOptions.defaultHeight = 480;
			windowOptions.defaultCentered = true;
			
			var testHandler:Function = function(event:Event, passThroughData:Object):void 
			{
			}
			
			var testErrorHandler:Function = function(passThroughData:Object):void 
			{
				Assert.fail("error creating application:" + passThroughData);
			}
			
			var asyncHandler:Function = Async.asyncHandler(WindowTest, testHandler, 15000, null, testErrorHandler)
			
			var handler:Function = function():void 
			{
				app.run(function ():void 
				{
					asyncHandler();
				});
			}

			var errorHandler:Function = function(reason:String):void 
			{
				trace("error creating application: " + reason);
				testErrorHandler(reason);
			}
			
			app = new Application(applicationOptions, handler, errorHandler);
		}
		
		[Test(async)]
		public function moveWindow():void 
		{
			var pObj:Object = new Object();
			var toTop:int = 100;
			var toLeft:int = 200;
			
			var asyncHandler:Function = Async.asyncHandler(this, 
					function(event:Event, passThroughData:Object):void 
					{
						//verify window location.
						Assert.assertEquals(passThroughData.bounds.left, toLeft);
						Assert.assertEquals(passThroughData.bounds.top, toTop);
					}, 
					15000, 
					pObj, 
					function(passThroughData:Object):void 
					{
						Assert.fail("error moving window");
					})
					
			app.window.moveTo(toLeft, toTop, function ():void 
			{
				//moveTo callback, verify window  location
				app.window.getBounds(function(bounds:Object):void 
				{
					trace("window moveTo call succeed");
					pObj.bounds = bounds;
					asyncHandler();
				});
				
			});
		}
		
		[Test(async)]
		public function resizeWindow():void 
		{
			var pObj:Object = new Object();
			var toWidth:int = 800;
			var toHeight:int = 600;
			
			var asyncHandler:Function = Async.asyncHandler(this, 
					function(event:Event, passThroughData:Object):void 
					{
						//verify window location.
						Assert.assertEquals(passThroughData.bounds.width, toWidth);
						Assert.assertEquals(passThroughData.bounds.height, toHeight);
					}, 
					15000, 
					pObj, 
					function(passThroughData:Object):void 
					{
						Assert.fail("error moving window");
					})
					
			app.window.resizeTo(toWidth, toHeight, "top-left", function ():void 
			{
				//moveTo callback, verify window  location
				app.window.getBounds(function(bounds:Object):void 
				{
					trace("window resizeTo call succeed");
					pObj.bounds = bounds;
					asyncHandler();
				});
				
			});
		}
		
		
		[AfterClass(async)]
		public static function closeApplication():void
		{
			app.close(false, 
				Async.asyncHandler(WindowTest, 
					function(event:Event, passThroughData:Object):void 
					{
						
					}, 
					15000, 
					null, 
					function(passThroughData:Object):void 
					{
						Assert.fail("error closing application:" + passThroughData);
					}));
		}
		
		
	}
}