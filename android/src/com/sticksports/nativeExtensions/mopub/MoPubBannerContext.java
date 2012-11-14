package com.sticksports.nativeExtensions.mopub;

import java.util.HashMap;
import java.util.Map;

import android.view.ViewGroup;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.mopub.mobileads.MoPubView;
import com.mopub.mobileads.MoPubView.OnAdClickedListener;
import com.mopub.mobileads.MoPubView.OnAdFailedListener;
import com.mopub.mobileads.MoPubView.OnAdLoadedListener;

public class MoPubBannerContext extends FREContext implements
	OnAdLoadedListener, OnAdFailedListener, OnAdClickedListener
{
	private MoPubBanner banner;
	
	public MoPubBanner getBanner()
	{
		if( banner == null )
		{
			banner = new MoPubBanner( this.getActivity() );
			banner.setOnAdLoadedListener( this );
			banner.setOnAdFailedListener( this );
			banner.setOnAdClickedListener( this );
		}
		return banner;
	}

	@Override
	public void dispose()
	{
		if ( banner != null )
		{
			banner.setOnAdLoadedListener( null );
			banner.setOnAdFailedListener( null );
			banner.setOnAdClickedListener( null );
			ViewGroup parent = (ViewGroup) banner.getParent();
			if ( parent != null )
			{
				parent.removeView( banner );
			}
			banner.destroy();
		}
	}

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put( "initialiseBanner", new MoPubBannerInitialise() );
		
		functionMap.put( "setTestMode", new MoPubBannerSetTestMode() );
		functionMap.put( "setAdUnitId", new MoPubBannerSetAdUnitId() );
		functionMap.put( "setAutorefresh", new MoPubBannerSetAutorefresh() );
		functionMap.put( "lockNativeAdsToOrientation", new MoPubBannerDoNothing() );
		
		functionMap.put( "getPositionX", new MoPubBannerGetPositionX() );
		functionMap.put( "setPositionX", new MoPubBannerSetPositionX() );
		functionMap.put( "getPositionY", new MoPubBannerGetPositionY() );
		functionMap.put( "setPositionY", new MoPubBannerSetPositionY() );
		functionMap.put( "getWidth", new MoPubBannerGetWidth() );
		functionMap.put( "setWidth", new MoPubBannerSetWidth() );
		functionMap.put( "getHeight", new MoPubBannerGetHeight() );
		functionMap.put( "setHeight", new MoPubBannerSetHeight() );
		
		functionMap.put( "setSize", new MoPubBannerSetSize() );
		functionMap.put( "getCreativeWidth", new MoPubBannerGetCreativeWidth() );
		functionMap.put( "getCreativeHeight", new MoPubBannerGetCreativeHeight() );
		
		functionMap.put( "loadBanner", new MoPubBannerLoad() );
		functionMap.put( "showBanner", new MoPubBannerShow() );
		functionMap.put( "removeBanner", new MoPubBannerRemove() );
		return functionMap;
	}
	
	public void OnAdLoaded( MoPubView mpv )
	{
		dispatchStatusEventAsync( "", MoPubMessages.bannerLoaded );
	}
	
	public void OnAdFailed( MoPubView mpv )
	{
		dispatchStatusEventAsync( "", MoPubMessages.bannerFailedToLoad );
	}

    public void OnAdClicked(MoPubView m)
	{
		dispatchStatusEventAsync( "", MoPubMessages.bannerAdClicked );
	}
}
