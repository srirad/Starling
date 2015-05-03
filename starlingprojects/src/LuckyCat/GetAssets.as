package LuckyCat
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Srini
	 */
	public class GetAssets
	{
		
	/*	[Embed(source="Media/Art/Images/bg.png")]
		public static const bg:Class;
		*/
		[Embed(source = "Media/Art/Images/playbtn.png")]
		public static const play1:Class;
		
		[Embed(source="Media/Art/Images/emissilebase.png")]
		public static const emissilebase:Class;
		
		[Embed(source="Media/Art/Images/missile.png")]
		public static const missile:Class;
		
		[Embed(source = "Media/Art/Images/asteriod.png")]
		public static const asteroid:Class;
		
		[Embed(source="Media/Art/Images/greenflight.png")]
		public static const greenFlight:Class;
		
		private static var gameTexture:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if (gameTexture[name] == undefined)
			{
				var bitmap:Bitmap = new GetAssets[name]();
				gameTexture[name] = Texture.fromBitmap(bitmap);
			}
			return gameTexture[name];
		}
	
	}
}