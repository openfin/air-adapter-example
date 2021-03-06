package test
{
	import flash.events.Event;

	
	import org.flexunit.async.Async;
	import org.flexunit.Assert;

	import fin.desktop.InterApplicationBus;

	public class InterApplicationBusTest
	{
		private var bus:InterApplicationBus;
		
		[Test(async)]
		public function publishMessage():void
		{
			bus = InterApplicationBus.getInstance();
			
			var receivedMessage:Object = null;
			var myMessage:Object = {"baz": false, "foo": 0};
			
			var testHandler:Function = function(event:Event, passThroughData:Object):void 
			{
				Assert.assertEquals(true, receivedMessage.baz === myMessage.baz);
			}
			
			var testErrorHandler:Function = function(passThroughData:Object):void 
			{
				Assert.fail("error publishing message:" + passThroughData);
			}

			var asyncHandler:Function = Async.asyncHandler(this, testHandler, 15000, null, testErrorHandler)
			
			bus.subscribe("*", "unit-test", function(message:Object, uuid: String):void 
			{
				receivedMessage = message;
				asyncHandler();
			});

			bus.publish("unit-test", myMessage);
		}
	}
}
