package com.sticksports.nativeExtensions.mopub;

import android.util.Log;
import android.widget.FrameLayout;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class MoPubBannerSetPositionX implements FREFunction
{

	@Override
	public FREObject call( FREContext ctx, FREObject[] args )
	{
		try
		{
			MoPubBannerContext context = (MoPubBannerContext) ctx;
			int x = args[0].getAsInt();
			context.getBanner().setPosX( x );
			
			FrameLayout.LayoutParams params = ( FrameLayout.LayoutParams ) context.getBanner().getLayoutParams();
		    if( params != null )
		    {
		    	params.leftMargin = x;
			   	context.getBanner().setLayoutParams(params);
		    }
		}
		catch ( Exception exception )
		{
			Log.w( "MoPub", exception );
		}
		return null;
	}
}
