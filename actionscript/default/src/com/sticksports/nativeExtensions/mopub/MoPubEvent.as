package com.sticksports.nativeExtensions.mopub
{
	import flash.events.Event;

	public class MoPubEvent extends Event
	{
		public static const LOADED : String = "MoPubEvent.LOADED";
		public static const LOAD_FAILED : String = "MoPubEvent.LOAD_FAILED";
		
		public function MoPubEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		override public function clone() : Event
		{
			return new MoPubEvent( type, bubbles, cancelable );
		}
	}
}
