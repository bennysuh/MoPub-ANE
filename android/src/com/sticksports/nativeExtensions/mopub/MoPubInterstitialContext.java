package com.sticksports.nativeExtensions.mopub;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.mopub.mobileads.MoPubErrorCode;
import com.mopub.mobileads.MoPubInterstitial;
import com.mopub.mobileads.MoPubInterstitial.InterstitialAdListener;

public class MoPubInterstitialContext extends FREContext implements InterstitialAdListener
{
	private MoPubInterstitial interstitial;
	
	public MoPubInterstitial createInterstitial( String adUnitId )
	{
		interstitial = new MoPubInterstitial( this.getActivity(), adUnitId );
		interstitial.setInterstitialAdListener( this );
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
			interstitial.setInterstitialAdListener( null );
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

    @Override
    public void onInterstitialLoaded(MoPubInterstitial interstitial) {
		dispatchStatusEventAsync( "", MoPubMessages.interstitialLoaded );
    }

    @Override
    public void onInterstitialFailed(MoPubInterstitial interstitial, MoPubErrorCode errorCode) {
		dispatchStatusEventAsync( "", MoPubMessages.interstitialFailedToLoad );
    }

    @Override
    public void onInterstitialShown(MoPubInterstitial interstitial) {

    }

    @Override
    public void onInterstitialClicked(MoPubInterstitial interstitial) {

    }

    @Override
    public void onInterstitialDismissed(MoPubInterstitial interstitial) {

    }
}
