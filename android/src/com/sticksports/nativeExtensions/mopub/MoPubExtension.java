package com.sticksports.nativeExtensions.mopub;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class MoPubExtension implements FREExtension
{
	@Override
	public FREContext createContext( String label )
	{
		if( label.equals( "interstitial" ) )
		{
			return new MoPubInterstitialContext();
		}
		return new MoPubBannerContext();
	}

	@Override
	public void dispose()
	{
	}

	@Override
	public void initialize()
	{
	}
}
