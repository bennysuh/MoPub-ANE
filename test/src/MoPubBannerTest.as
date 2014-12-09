﻿package
{
	import com.sticksports.nativeExtensions.mopub.MoPub;
	import com.sticksports.nativeExtensions.mopub.MoPubBanner;
	import com.sticksports.nativeExtensions.mopub.MoPubEvent;
	import com.sticksports.nativeExtensions.mopub.MoPubSize;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	[SWF(width='320', height='480', frameRate='30', backgroundColor='#000000')]
	
	public class MoPubBannerTest extends Sprite
	{
		private var direction : int = 1;
		private var shape : Shape;
		private var feedback : TextField;
		
		private var buttonFormat : TextFormat;
		
		private var banner : MoPubBanner;
		private var bannerCount : int = 0;
		
		//iOS
		private var iosBannerUnitId : String = "f768795308a040cea86dc6eb6167fae6";
		// Android
		private var androidBannerUnitId : String = "a3466174a82b4ea4809e55e95914f73f";
		
		public function get bannerUnitId() : String
		{
			var os : String = Capabilities.version.substr(0,3);
			if( os == "IOS" )
			{
				return iosBannerUnitId;
			}
			else
			{
				return androidBannerUnitId;
			}
		}

		public function MoPubBannerTest()
		{
			shape = new Shape();
			shape.graphics.beginFill( 0x666666 );
			shape.graphics.drawCircle( 0, 0, 100 );
			shape.graphics.endFill();
			shape.x = 0;
			shape.y = 240;
			addChild( shape );
			
			feedback = new TextField();
			var format : TextFormat = new TextFormat();
			format.font = "_sans";
			format.size = 16;
			format.color = 0xFFFFFF;
			feedback.defaultTextFormat = format;
			feedback.width = 320;
			feedback.height = 260;
			feedback.x = 10;
			feedback.y = 230;
			feedback.multiline = true;
			feedback.wordWrap = true;
			feedback.text = "Hello";
			addChild( feedback );
			
			createButtons();
			
			addEventListener( Event.ENTER_FRAME, animate );
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, init );
		}
		
		private function createButtons() : void
		{
			var tf : TextField = createButton( "createBanner" );
			tf.x = 10;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, createBanner );
			addChild( tf );
			
			tf = createButton( "loadBanner" );
			tf.x = 170;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, loadBanner );
			addChild( tf );
			
			tf = createButton( "showBanner" );
			tf.x = 10;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, showBanner );
			addChild( tf );
			
			tf = createButton( "moveBanner" );
			tf.x = 170;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, moveBanner );
			addChild( tf );
			
			tf = createButton( "removeBanner" );
			tf.x = 10;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, removeBanner );
			addChild( tf );
			
			tf = createButton( "releaseBanner" );
			tf.x = 170;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, releaseBanner );
			addChild( tf );
			
			tf = createButton( "getSize" );
			tf.x = 10;
			tf.y = 130;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, getSize );
			addChild( tf );
			
			tf = createButton( "matchSize" );
			tf.x = 170;
			tf.y = 130;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, matchSize );
			addChild( tf );
			
			tf = createButton( "setAutorefresh" );
			tf.x = 10;
			tf.y = 170;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, setAutorefresh );
			addChild( tf );
			
			tf = createButton( "unsetAutorefresh" );
			tf.x = 170;
			tf.y = 170;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, unsetAutorefresh );
			addChild( tf );
		}
		
		private function createButton( label : String ) : TextField
		{
			if( !buttonFormat )
			{
				buttonFormat = new TextFormat();
				buttonFormat.font = "_sans";
				buttonFormat.size = 14;
				buttonFormat.bold = true;
				buttonFormat.color = 0xFFFFFF;
				buttonFormat.align = TextFormatAlign.CENTER;
			}
			
			var textField : TextField = new TextField();
			textField.defaultTextFormat = buttonFormat;
			textField.width = 140;
			textField.height = 30;
			textField.text = label;
			textField.backgroundColor = 0xCC0000;
			textField.background = true;
			textField.selectable = false;
			textField.multiline = false;
			textField.wordWrap = false;
			return textField;
		}
		
		private function createBanner( event : MouseEvent ) : void
		{
			feedback.text = "new MoPubBanner( bannerUnitId, MoPubSize.banner );";
			banner = new MoPubBanner( bannerUnitId, MoPubSize.banner );
			bannerCount++;
			banner.x = 0;
			banner.y = Capabilities.screenResolutionY - bannerCount * banner.height;
			//banner.testing = true;
		}
		
		private function loadBanner( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.load();" );
			setBannerListeners( banner );
			banner.load();
		}
				
		private function showBanner( event : MouseEvent ) : void
		{
			
			feedback.appendText( "\nbanner.show();" );
			banner.show();
		}
				
		private function removeBanner( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.remove();" );
			banner.remove();
		}
				
		private function releaseBanner( event : MouseEvent ) : void
		{
			removeBannerListeners( banner );
			feedback.appendText( "\nbanner = null;" );
			banner = null;
		}
		
		private function matchSize( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.width = banner.creativeWidth\nbanner.height = banner.creativeHeight" );
			banner.width = banner.creativeWidth;
			banner.height = banner.creativeHeight;
		}
		
		private function getSize( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.width = " + banner.width );
			feedback.appendText( "\nbanner.height = " + banner.height );
			feedback.appendText( "\nbanner.creativeWidth = " + banner.creativeWidth );
			feedback.appendText( "\nbanner.creativeHeight = " + banner.creativeHeight );
		}
		
		private function moveBanner( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.y = 0" );
			banner.y = 0;
		}
		
		private function setAutorefresh( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.autorefresh = true" );
			banner.autorefresh = true;
		}
		
		private function unsetAutorefresh( event : MouseEvent ) : void
		{
			feedback.appendText( "\nbanner.autorefresh = false" );
			banner.autorefresh = false;
		}
		
		private function setBannerListeners( banner : MoPubBanner ) : void
		{
			banner.addEventListener( MoPubEvent.LOADED, eventReceived );
			banner.addEventListener( MoPubEvent.LOAD_FAILED, eventReceived );
			banner.addEventListener( MoPubEvent.AD_CLICKED, eventReceived );
			banner.addEventListener( MoPubEvent.AD_CLOSED, eventReceived );
		}
		
		private function removeBannerListeners( banner : MoPubBanner ) : void
		{
			banner.removeEventListener( MoPubEvent.LOADED, eventReceived );
			banner.removeEventListener( MoPubEvent.LOAD_FAILED, eventReceived );
			banner.removeEventListener( MoPubEvent.AD_CLICKED, eventReceived );
			banner.removeEventListener( MoPubEvent.AD_CLOSED, eventReceived );
		}
		
		private function eventReceived( event : MoPubEvent ) : void
		{
			feedback.appendText( "\n  " + event.type );
		}
				
		private function animate( event : Event ) : void
		{
			shape.x += direction;
			if( shape.x <= 0 )
			{
				direction = 1;
			}
			if( shape.x > 320 )
			{
				direction = -1;
			}
		}
	}
}