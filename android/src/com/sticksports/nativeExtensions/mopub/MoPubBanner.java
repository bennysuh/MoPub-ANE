package com.sticksports.nativeExtensions.mopub;

import android.content.Context;
import android.util.AttributeSet;

import com.mopub.mobileads.MoPubView;

public class MoPubBanner extends MoPubView
{
	private int posX;
	private int posY;
	private int plannedWidth;
	private int plannedHeight;

	public MoPubBanner( Context context )
	{
		super( context );
		posX = 0;
		posY = 0;
		plannedWidth = 0;
		plannedHeight = 0;
	}

	public MoPubBanner( Context context, AttributeSet attrs )
	{
		super( context, attrs );
	}

	public int getPosX()
	{
		return posX;
	}

	public void setPosX( int x )
	{
		posX = x;
	}

	public int getPosY()
	{
		return posY;
	}

	public void setPosY( int y )
	{
		posY = y;
	}

	public int getPlannedWidth()
	{
		return plannedWidth;
	}
	
	public void setPlannedWidth( int width )
	{
		plannedWidth = width;
	}
	
	public int getPlannedHeight()
	{
		return plannedHeight;
	}
	
	public void setPlannedHeight( int height )
	{
		plannedHeight = height;
	}
}
