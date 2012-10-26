package com.sticksports.nativeExtensions.mopub;

import android.app.Activity;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class MoPubBannerShow implements FREFunction
{

	@Override
	public FREObject call( FREContext ctx, FREObject[] args )
	{
		try
		{
			MoPubBannerContext context = (MoPubBannerContext) ctx;
			Activity activity = context.getActivity();
			double density = activity.getResources().getDisplayMetrics().density;
			
			RelativeLayout container = new RelativeLayout( activity );
			ViewGroup frameLayout = (ViewGroup) activity.findViewById( android.R.id.content );
			frameLayout = (ViewGroup) frameLayout.getChildAt( 0 );
			frameLayout.addView(container, new FrameLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));
			RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams( (int) Math.ceil( context.getBanner().getAdWidth() * density ), (int) Math.ceil( context.getBanner().getAdHeight() * density ) );
			params.setMargins( context.getBanner().getXPos(), context.getBanner().getYPos(), 0, 0 );
			container.addView( context.getBanner(), params );
		}
		catch ( Exception exception )
		{
			Log.w( "MoPub", exception );
		}
		return null;
	}
}
