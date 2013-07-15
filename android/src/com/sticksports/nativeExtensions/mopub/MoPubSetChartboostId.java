package com.sticksports.nativeExtensions.mopub;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import com.mopub.mobileads.ChartboostInterstitial;

public class MoPubSetChartboostId implements FREFunction
{
	@Override
	public FREObject call( FREContext ctx, FREObject[] args )
	{
		try
		{
			String chartboostId = args[0].getAsString();
			String chartboostSignature = args[1].getAsString();
			ChartboostInterstitial.APP_ID_KEY = chartboostId;
			ChartboostInterstitial.APP_SIGNATURE_KEY = chartboostSignature;
		}
		catch ( Exception exception )
		{
			Log.w( "MoPub", exception );
		}
		return null;
	}
}
