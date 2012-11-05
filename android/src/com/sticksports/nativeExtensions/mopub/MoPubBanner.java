package com.sticksports.nativeExtensions.mopub;

import android.content.Context;
import android.util.AttributeSet;

import com.mopub.mobileads.MoPubView;

public class MoPubBanner extends MoPubView
{
	private int xPos;
	private int yPos;
	private int plannedWidth;
	private int plannedHeight;

	public MoPubBanner( Context context )
	{
		super( context );
		xPos = 0;
		yPos = 0;
		plannedWidth = 0;
		plannedHeight = 0;
	}

	public MoPubBanner( Context context, AttributeSet attrs )
	{
		super( context, attrs );
	}

	public int getXPos()
	{
		return xPos;
	}

	public void setXPos( int x )
	{
		xPos = x;
	}

	public int getYPos()
	{
		return yPos;
	}

	public void setYPos( int y )
	{
		yPos = y;
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
