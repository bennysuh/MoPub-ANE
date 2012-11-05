package com.sticksports.nativeExtensions.mopub;

import android.util.Log;
import android.widget.RelativeLayout;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class MoPubBannerSetHeight implements FREFunction
{

	@Override
	public FREObject call( FREContext ctx, FREObject[] args )
	{
		try
		{
			MoPubBannerContext context = (MoPubBannerContext) ctx;
			double height = args[0].getAsDouble();
			context.getBanner().setPlannedHeight( (int) Math.round( height ) );
			
		    RelativeLayout.LayoutParams params = ( RelativeLayout.LayoutParams ) context.getBanner().getLayoutParams();
		    if( params != null )
		    {
		    	params.height = context.getBanner().getPlannedHeight();
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
