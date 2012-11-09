package com.sticksports.nativeExtensions.mopub;

import android.app.Activity;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.FrameLayout;

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
			
			ViewGroup frameLayout = (ViewGroup) activity.findViewById( android.R.id.content );
			frameLayout = (ViewGroup) frameLayout.getChildAt( 0 );
			FrameLayout.LayoutParams params = new FrameLayout.LayoutParams( context.getBanner().getPlannedWidth(), context.getBanner().getPlannedHeight() );
			params.setMargins( context.getBanner().getPosX(), context.getBanner().getPosY(), 0, 0 );
			frameLayout.addView( context.getBanner(), params );
			
//			frameLayout.addView(container, new FrameLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));
//			RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams( (int) Math.ceil( context.getBanner().getAdWidth() * density ), (int) Math.ceil( context.getBanner().getAdHeight() * density ) );
//			RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams( RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT );
//			params.setMargins( context.getBanner().getXPos(), context.getBanner().getYPos(), 0, 0 );
//			container.addView( context.getBanner(), params );
		}
		catch ( Exception exception )
		{
			Log.w( "MoPub", exception );
		}
		return null;
	}
}
