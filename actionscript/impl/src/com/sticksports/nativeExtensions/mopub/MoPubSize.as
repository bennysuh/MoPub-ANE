package com.sticksports.nativeExtensions.mopub
{
	public class MoPubSize
	{
		// 320x50.
		public static const banner : MoPubSize = new MoPubSize( 1 );
		
		// 300x250.
		public static const mediumRectangle : MoPubSize = new MoPubSize( 2 );
		
		// 728x90
		public static const leaderboard : MoPubSize = new MoPubSize( 3 );
		
		// 160x600.
		public static const wideSkyscraper : MoPubSize = new MoPubSize( 4 );
		
		
		internal var id : int;
		
		public function MoPubSize( id : int )
		{
			this.id = id;
		}
	}
}
