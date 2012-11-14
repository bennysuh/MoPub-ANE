package com.sticksports.nativeExtensions.mopub;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class MoPubInterstitialSetTestMode implements FREFunction
{

	@Override
	public FREObject call( FREContext ctx, FREObject[] args )
	{
		try
		{
			MoPubInterstitialContext context = (MoPubInterstitialContext) ctx;
			boolean testing = args[0].getAsBool();
			context.getInterstitial().setTesting( testing );
		}
		catch ( Exception exception )
		{
			Log.w( "MoPub", exception );
		}
		return null;
	}

}
