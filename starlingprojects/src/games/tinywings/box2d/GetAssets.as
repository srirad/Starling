package games.tinywings.box2d
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
		
		//	[Embed(source = "Media/Art/Images/bg.png")]
		// [Embed(source="Assets/bg.png")]
		[Embed(source="../../../jungle/Assets/bg.png")]
		
		public static const bg:Class;
		
		
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