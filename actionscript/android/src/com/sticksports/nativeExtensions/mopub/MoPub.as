package com.sticksports.nativeExtensions.mopub
{
	import flash.external.ExtensionContext;

	public class MoPub
	{
		private static var extensionContext : ExtensionContext;
		private static var scaleFactor : Number;

		public static function get adScaleFactor() : Number
		{
			if( !scaleFactor )
			{
				if ( !extensionContext )
				{
					extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.MoPub", "mopub" );
				}
				scaleFactor = extensionContext.call( "getAdScaleFactor" ) as Number;
			}
			return scaleFactor;
		}
		
		public static function setChartboostId( appId : String, appSignature : String ) : void
		{
			if ( !extensionContext )
			{
				extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.MoPub", "mopub" );
			}
			extensionContext.call( "setChartboostId", appId, appSignature );
		}
	}
}
