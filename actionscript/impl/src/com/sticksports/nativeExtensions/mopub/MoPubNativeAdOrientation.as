package com.sticksports.nativeExtensions.mopub
{
	public class MoPubNativeAdOrientation
	{
		public static const any : MoPubNativeAdOrientation = new MoPubNativeAdOrientation( 0 );
		
		public static const portrait : MoPubNativeAdOrientation = new MoPubNativeAdOrientation( 1 );
		
		public static const landscape : MoPubNativeAdOrientation = new MoPubNativeAdOrientation( 2 );
		
		internal var id : int;
		
		public function MoPubNativeAdOrientation( id : int )
		{
			this.id = id;
		}
	}
}
