package com.sticksports.nativeExtensions.mopub
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class MoPubBanner extends EventDispatcher
	{
// native method names

		private static const getDisplayDensity : String = "getDisplayDensity";
		
		private static const setTestMode : String = "setTestMode";
		private static const setAdUnitId : String = "setAdUnitId";
		
		private static const loadBanner : String = "loadBanner";
		private static const showBanner : String = "showBanner";
		private static const removeBanner : String = "removeBanner";
		private static const releaseBanner : String = "releaseBanner";

// class variables

		private var extensionContext : ExtensionContext = null;

		private var _adUnitId : String;
		private var _testing : Boolean;

		private var _x : Number = 0;
		private var _y : Number = 0;
		private var _creativeWidth : Number;
		private var _creativeHeight : Number;

		private var _size : MoPubSize = MoPubSize.banner;

// properties

		public function get adUnitId() : String
		{
			return _adUnitId;
		}

		public function set adUnitId( adUnitId : String ) : void
		{
			this._adUnitId = adUnitId;
		}

		public function get testing() : Boolean
		{
			return _testing;
		}

		public function set testing( testing : Boolean ) : void
		{
			this._testing = testing;
		}

		public function get x() : Number
		{
			return _x;
		}

		public function set x( x : Number ) : void
		{
			this._x = x;
		}

		public function get y() : Number
		{
			return _y;
		}

		public function set y( y : Number ) : void
		{
			this._y = y;
		}

		public function get size() : MoPubSize
		{
			return _size;
		}

		public function set size( size : MoPubSize ) : void
		{
			this._size = size;
		}

		public function get creativeWidth() : Number
		{
			return _creativeWidth;
		}

		public function get creativeHeight() : Number
		{
			return _creativeHeight;
		}

// methods

		public function MoPubBanner()
		{
			extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.MoPubBanner", null );
			extensionContext.addEventListener( StatusEvent.STATUS, handleStatusEvent );
		}

		public function load() : void
		{
			MoPub.loadBanner( this );
		}

		public function show() : void
		{
			MoPub.showBanner( this );
		}
		
		public function loadAndShow() : void
		{
			MoPub.loadAndShowBanner( this );
		}

		public function remove() : void
		{
			MoPub.removeBanner( this );
		}
		
		public function release() : void
		{
			MoPub.releaseBanner( this );
		}
		
		public function removeAndRelease() : void
		{
			MoPub.removeAndReleaseBanner( this );
		}
	}
}

