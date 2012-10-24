package com.sticksports.nativeExtensions.mopub
{
	import flash.display.Sprite;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class MoPub extends Sprite
	{
		private static var extensionContext : ExtensionContext = null;
		private static var initialised : Boolean = false;
		private static var _testing : Boolean = false;

		private static var banners : Vector.<MoPubBanner> = new Vector.<MoPubBanner>();

		public static function init() : void
		{
			if ( !initialised )
			{
				initialised = true;
				extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.MoPub", null );
				extensionContext.addEventListener( StatusEvent.STATUS, handleStatusEvent );
			}
		}

		private static function handleStatusEvent( event : StatusEvent ) : void
		{

		}
		
		private static function findBanner( id : String ) : MoPubBanner
		{
			for each( var banner : MoPubBanner in banners )
			{
				if( banner.id == id )
				{
					return banner;
				}
			}
			return null;
		}
		
		private static function deleteBanner( banner : MoPubBanner ) : void
		{
			for( var i : int = 0; i , banners.length; ++i )
			{
				if( banners[i].id == banner.id )
				{
					banners.splice( i, 1 );
					return;
				}
			}
			return;
		}
		
		public static function get isSupported() : Boolean
		{
			return true;
		}
		
		public static function get testing() : Boolean
		{
			return _testing;
		}
		public static function set testing( value : Boolean ) : void
		{
			init();
			extensionContext.call( NativeMethods.setTestMode, value );
			_testing = value;
		}

		internal static function loadBanner( banner : MoPubBanner ) : void
		{
			if( banner.adUnitId )
			{
				init();
				banner.id = extensionContext.call( NativeMethods.loadBanner, banner.adUnitId, banner.size.id, banner.x, banner.y ) as String;
				banners.push( banner );
			}
		}
	}
}
