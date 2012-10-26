package com.sticksports.nativeExtensions.mopub
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class MoPubBanner extends EventDispatcher
	{
// native method names

		private static const initialiseBanner : String = "initialiseBanner";
		private static const getDisplayDensity : String = "getDisplayDensity";
		private static const getCreativeWidth : String = "getCreativeWidth";
		private static const getCreativeHeight : String = "getCreativeHeight";
		
		private static const setAdUnitId : String = "setAdUnitId";
		private static const setIgnoresAutorefresh : String = "setIgnoresAutorefresh";
		private static const setTestMode : String = "setTestMode";
		private static const setPositionX : String = "setPositionX";
		private static const setPositionY : String = "setPositionY";
		
		private static const loadBanner : String = "loadBanner";
		private static const showBanner : String = "showBanner";
		private static const removeBanner : String = "removeBanner";

// class variables

		private var extensionContext : ExtensionContext = null;

		private var _adUnitId : String;
		private var _ignoresAutorefresh : Boolean = false;
		private var _testing : Boolean = false;

		private var _x : Number = 0;
		private var _y : Number = 0;

		private var _size : MoPubSize = MoPubSize.banner;

// properties

		public function get adUnitId() : String
		{
			return _adUnitId;
		}

		public function set adUnitId( value : String ) : void
		{
			_adUnitId = value;
			extensionContext.call( setAdUnitId, value );
		}

		public function get ignoresAutorefresh() : Boolean
		{
			return _ignoresAutorefresh;
		}

		public function set ignoresAutorefresh( value : Boolean ) : void
		{
			_ignoresAutorefresh = value;
			extensionContext.call( setIgnoresAutorefresh, value );
		}

		public function get testing() : Boolean
		{
			return _testing;
		}

		public function set testing( value : Boolean ) : void
		{
			_testing = value;
			extensionContext.call( setTestMode, value );
		}

		public function get x() : Number
		{
			return _x;
		}

		public function set x( value : Number ) : void
		{
			_x = value;
			extensionContext.call( setPositionX, value );
		}

		public function get y() : Number
		{
			return _y;
		}

		public function set y( value : Number ) : void
		{
			_y = value;
			extensionContext.call( setPositionY, value );
		}

		public function get creativeWidth() : Number
		{
			return extensionContext.call( getCreativeWidth ) as Number;
		}

		public function get creativeHeight() : Number
		{
			return extensionContext.call( getCreativeHeight ) as Number;
		}

		public function get displayDensity() : Number
		{
			return extensionContext.call( getDisplayDensity ) as Number;
		}

// methods

		public function MoPubBanner( adUnitId : String, size : MoPubSize )
		{
			extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.MoPub", "banner" );
			extensionContext.addEventListener( StatusEvent.STATUS, handleStatusEvent );
			_adUnitId = adUnitId;
			_size = size;
			extensionContext.call( initialiseBanner, adUnitId, size.id );
		}
		
		private function handleStatusEvent( event : StatusEvent ) : void
		{
			trace( "StatusEvent", event.level );
			switch( event.level )
			{
				case InternalMessages.bannerLoaded :
					dispatchEvent( new MoPubEvent( MoPubEvent.LOADED ) );
					break;
				case InternalMessages.bannerFailedToLoad :
					dispatchEvent( new MoPubEvent( MoPubEvent.LOAD_FAILED ) );
					break;
			}
		}

		public function load() : void
		{
			extensionContext.call( loadBanner );
		}

		public function show() : void
		{
			extensionContext.call( showBanner );
		}

		public function remove() : void
		{
			extensionContext.call( removeBanner );
		}
	}
}

