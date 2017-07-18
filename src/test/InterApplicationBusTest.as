package
{
	import flash.events.Event;
	import mx.utils.ObjectUtil;
	
	
	import org.flexunit.async.Async;
	import org.flexunit.Assert;

	import fin.desktop.InterApplicationBus;

	public class InterApplicationBusTest
	{
		private var bus:InterApplicationBus;
		
		[Test(async)]
		public function publishMessage()
		{
			bus = InterApplicationBus.getInstance();
			
			var receivedMessage = null;
			var myMessage = {"baz": false, "foo": 0};
			
			var testHandler:Function = function(event:Event, passThroughData:Object):void 
			{
				Assert.assertEquals(0, ObjectUtil.compare(receivedMessage, myMessage));
			}
			
			var testErrorHandler:Function = function(passThroughData:Object):void 
			{
				Assert.fail("error publishing message:" + passThroughData);
			}

			var asyncHandler = Async.asyncHandler(this, testHandler, 15000, null, testErrorHandler)
			
			bus.subscribe("*", "unit-test", function(message:Object, uuid: String):void 
			{
				receivedMessage = message;
				asyncHandler();
			});

			bus.publish("unit-test", myMessage);
		}
	}
}
