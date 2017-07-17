/**
 * Created by haseebriaz on 22/01/2015.
 */
package
{
	
	import org.flexunit.async.Async;
	import org.flexunit.Assert;
	
	import fin.desktop.Notification;
	import fin.desktop.NotificationOptions;
	import fin.desktop.events.NotificationEvent;
	
	public class NotificationTest
	{
		
		[Test(async)]
		public function createNotification()
		{
			
			var handler:Function = function(event, obj):void
			{
			}
			
			var timeoutHandler:Function = function():void
			{
				Assert.fail("timeout creating notification");
			}
			
			var eventHandler:Function = Async.asyncHandler(this, handler, 5000, null, timeoutHandler);
			
			var callback:Function = function():void
			{
				eventHandler();
			}
			
			var notification:Notification = new Notification(new NotificationOptions("http://demoappdirectory.openf.in/desktop/config/apps/OpenFin/HelloOpenFin/views/notification.html", "test message1!", "60000"), callback);
		}
	
	}
}
