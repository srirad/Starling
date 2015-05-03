package complexbox2dobject{

	import citrus.core.State;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;

	/**
	 * @author Aymeric
	 */
	public class ComplexBox2DObjectGameState extends State {

		public function ComplexBox2DObjectGameState() {
			super();
		}

		override public function initialize():void {

			super.initialize();

			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			

			var platTop:Platform = new Platform("platTop", {x:stage.stageWidth / 2, width:stage.stageWidth, y:20});
			add(platTop);

			
			var platBot:Platform = new Platform("platTop", {x:stage.stageWidth / 2, width:stage.stageWidth, y:stage.stageHeight - 50});
			add(platBot);
			
			// There are two differents demos, comment those you don't need.
			
			// DEMO 1

			var ropeChain:RopeChain = new RopeChain("ropeChain", {hangTo:platTop, radius:15, y:150, x:30, view:new RopeChainGraphics(), registration:"topLeft"});
			add(ropeChain);
		
		}

	}
}
