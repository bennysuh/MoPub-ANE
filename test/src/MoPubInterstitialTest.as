package
{
	import com.sticksports.nativeExtensions.mopub.MoPub;
	import com.sticksports.nativeExtensions.mopub.MoPubEvent;
	import com.sticksports.nativeExtensions.mopub.MoPubInterstitial;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	[SWF(width='320', height='480', frameRate='30', backgroundColor='#000000')]
	
	public class MoPubInterstitialTest extends Sprite
	{
		private var direction : int = 1;
		private var shape : Shape;
		private var feedback : TextField;
		
		private var buttonFormat : TextFormat;
		
		private var interstitial : MoPubInterstitial;
		
		//iOS
		private var iosInterstitialUnitId : String = "agltb3B1Yi1pbmNyDQsSBFNpdGUY7b_SFgw";
		private var iosChartboostAppId : String = "51cc1fdc17ba475522000000";
		private var iosChartboostAppSignature : String = "23c2c4b60210c17de3c030bafe802454ce820761";
		// Android
		private var androidInterstitialUnitId : String = "agltb3B1Yi1pbmNyDQsSBFNpdGUY0cfSFgw";
		private var androidChartboostAppId : String = "51cc229e16ba47cc43000004";
		private var androidChartboostAppSignature : String = "d54494905dc1aec84bb57ff70842616af0a8b11f";
		
		public function get interstitialUnitId() : String
		{
			var os : String = Capabilities.version.substr(0,3);
			if( os == "IOS" )
			{
				return iosInterstitialUnitId;
			}
			else
			{
				return androidInterstitialUnitId;
			}
		}
		public function get chartboostAppId() : String
		{
			var os : String = Capabilities.version.substr(0,3);
			if( os == "IOS" )
			{
				return iosChartboostAppId;
			}
			else
			{
				return androidChartboostAppId;
			}
		}
		public function get chartboostAppSignature() : String
		{
			var os : String = Capabilities.version.substr(0,3);
			if( os == "IOS" )
			{
				return iosChartboostAppSignature;
			}
			else
			{
				return androidChartboostAppSignature;
			}
		}
		
		public function MoPubInterstitialTest()
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
			feedback.height = 300;
			feedback.x = 10;
			feedback.y = 190;
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
			var tf : TextField = createButton( "createInterstitial" );
			tf.x = 10;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, createInterstitial );
			addChild( tf );
			
			tf = createButton( "loadInterstitial" );
			tf.x = 170;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, loadInterstitial );
			addChild( tf );
			
			tf = createButton( "showInterstitial" );
			tf.x = 10;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, showInterstitial );
			addChild( tf );
			
			tf = createButton( "releaseInterstitial" );
			tf.x = 170;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, releaseInterstitial );
			addChild( tf );
			
			tf = createButton( "getIsReady" );
			tf.x = 10;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, getIsReady );
			addChild( tf );
			
			tf = createButton( "setChartboostId" );
			tf.x = 170;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, setChartboostAppId );
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
		
		private function createInterstitial( event : MouseEvent ) : void
		{
			feedback.text = "new MoPubInterstitial( interstitialUnitId );";
			interstitial = new MoPubInterstitial( interstitialUnitId );
			//interstitial.testing = true;
		}
		
		private function loadInterstitial( event : MouseEvent ) : void
		{
			feedback.appendText( "\ninterstitial.load();" );
			setInterstitialListeners( interstitial );
			interstitial.load();
		}
				
		private function showInterstitial( event : MouseEvent ) : void
		{
			
			feedback.appendText( "\ninterstitial.show();" );
			interstitial.show();
		}
				
		private function releaseInterstitial( event : MouseEvent ) : void
		{
			removeInterstitialListeners( interstitial );
			feedback.appendText( "\ninterstitial = null;" );
			interstitial = null;
		}
		
		private function getIsReady( event : MouseEvent ) : void
		{
			feedback.appendText( "\ninterstitial.isReady = " + interstitial.isReady );
		}
		
		private function setChartboostAppId( event : MouseEvent ) : void
		{
			feedback.appendText( "\nMoPub.setChartboostId( ... )" );
			MoPub.setChartboostId( chartboostAppId, chartboostAppSignature );
		}
		
		private function setInterstitialListeners( interstitial : MoPubInterstitial ) : void
		{
			interstitial.addEventListener( MoPubEvent.LOADED, eventReceived );
			interstitial.addEventListener( MoPubEvent.LOAD_FAILED, eventReceived );
			interstitial.addEventListener( MoPubEvent.AD_CLOSED, eventReceived );
		}
		
		private function removeInterstitialListeners( interstitial : MoPubInterstitial ) : void
		{
			interstitial.removeEventListener( MoPubEvent.LOADED, eventReceived );
			interstitial.removeEventListener( MoPubEvent.LOAD_FAILED, eventReceived );
			interstitial.removeEventListener( MoPubEvent.AD_CLOSED, eventReceived );
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