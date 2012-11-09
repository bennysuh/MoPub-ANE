package com.sticksports.nativeExtensions.mopub;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class MoPubBannerGetHeight implements FREFunction
{

	@Override
	public FREObject call( FREContext ctx, FREObject[] args )
	{
		try
		{
			MoPubBannerContext context = (MoPubBannerContext) ctx;
			return FREObject.newObject( context.getBanner().getPlannedHeight() );
		}
		catch ( Exception exception )
		{
			Log.w( "MoPub", exception );
		}
		return null;
	}

}
