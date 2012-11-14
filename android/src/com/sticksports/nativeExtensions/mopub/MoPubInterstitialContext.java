package com.sticksports.nativeExtensions.mopub;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.mopub.mobileads.MoPubInterstitial;
import com.mopub.mobileads.MoPubInterstitial.MoPubInterstitialListener;

public class MoPubInterstitialContext extends FREContext implements MoPubInterstitialListener
{
	private MoPubInterstitial interstitial;
	
	public MoPubInterstitial createInterstitial( String adUnitId )
	{
		interstitial = new MoPubInterstitial( this.getActivity(), adUnitId );
		interstitial.setListener( this );
		return interstitial;
	}

	public MoPubInterstitial getInterstitial()
	{
		return interstitial;
	}
	
	@Override
	public void dispose()
	{
		if ( interstitial != null )
		{
			interstitial.setListener( null );
			interstitial.destroy();
		}
	}

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put( "initialiseInterstitial", new MoPubInterstitialInitialise() );
		
		functionMap.put( "setInterstitialTestMode", new MoPubInterstitialSetTestMode() );
		functionMap.put( "getInterstitialReady", new MoPubInterstitialGetIsReady() );
		
		functionMap.put( "loadInterstitial", new MoPubInterstitialLoad() );
		functionMap.put( "showInterstitial", new MoPubInterstitialShow() );
		return functionMap;
	}
	
	public void OnInterstitialLoaded()
	{
		dispatchStatusEventAsync( "", MoPubMessages.interstitialLoaded );
	}
	
	public void OnInterstitialFailed()
	{
		dispatchStatusEventAsync( "", MoPubMessages.interstitialFailedToLoad );
	}
}
