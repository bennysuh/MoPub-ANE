package com.sticksports.nativeExtensions.mopub
{
	import flash.events.EventDispatcher;

	public class MoPubBanner extends EventDispatcher
	{
// class variables

		private var _adUnitId : String;
		private var _testing : Boolean;

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
		}

		public function get testing() : Boolean
		{
			return _testing;
		}

		public function set testing( value : Boolean ) : void
		{
			_testing = value;
		}

		public function get x() : Number
		{
			return _x;
		}

		public function set x( value : Number ) : void
		{
			_x = value;
		}

		public function get y() : Number
		{
			return _y;
		}

		public function set y( value : Number ) : void
		{
			_y = value;
		}

		public function get size() : MoPubSize
		{
			return _size;
		}

		public function set size( value : MoPubSize ) : void
		{
			_size = value;
		}

		public function get creativeWidth() : Number
		{
			return 0;
		}

		public function get creativeHeight() : Number
		{
			return 0;
		}

		public function get displayDensity() : Number
		{
			return 1;
		}

// methods

		public function MoPubBanner( adUnitId : String, size : MoPubSize )
		{
			_adUnitId = adUnitId;
			_size = size;
		}
		
		public function load() : void
		{
		}

		public function show() : void
		{
		}

		public function remove() : void
		{
		}
	}
}

