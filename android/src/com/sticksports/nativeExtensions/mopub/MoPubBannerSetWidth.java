package com.sticksports.nativeExtensions.mopub;

import android.util.Log;
import android.widget.RelativeLayout;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class MoPubBannerSetWidth implements FREFunction
{

	@Override
	public FREObject call( FREContext ctx, FREObject[] args )
	{
		try
		{
			MoPubBannerContext context = (MoPubBannerContext) ctx;
			double width = args[0].getAsDouble();
			context.getBanner().setPlannedWidth( (int) Math.round( width ) );
			
		    RelativeLayout.LayoutParams params = ( RelativeLayout.LayoutParams ) context.getBanner().getLayoutParams();
		    if( params != null )
		    {
		    	params.width = context.getBanner().getPlannedWidth();
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
