package entity {

	import citrus.core.CitrusObject;
	import citrus.core.State;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.system.Entity;
	import citrus.system.components.InputComponent;
	import citrus.system.components.box2d.hero.HeroCollisionComponent;
	import citrus.system.components.box2d.hero.HeroMovementComponent;
	import citrus.system.components.box2d.hero.HeroViewComponent;
	import citrus.math.MathUtils;
	import citrus.math.MathVector;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author Aymeric
	 */
	public class EntityGameState extends State {
		
		private var _heroEntity:Entity;
		private var _view:HeroViewComponent;
		private var _physics:DraggableHeroPhysicsComponent;

		public function EntityGameState() {
			
			super();
		}

		override public function initialize():void {
			
			super.initialize();
			
			var box2d:Box2D = new Box2D("box2D");
			box2d.visible = true;
			add(box2d);
			
			_heroEntity = new Entity("heroEntity");
			
			_physics = new DraggableHeroPhysicsComponent("physics", {x:200, y:270, width:40, height:60});
			var input:InputComponent = new InputComponent("input");
			var collision:HeroCollisionComponent = new HeroCollisionComponent("collision");
			var move:HeroMovementComponent = new HeroMovementComponent("move");
			_view = new HeroViewComponent("view", {touchable:true, view:"PatchSpriteArt.swf"});
			
			_heroEntity.add(_physics).add(input).add(collision).add(move).add(_view);
			_heroEntity.initialize();
	     //	view.setupCamera(_heroEntity, new MathVector(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 1550, 450), new MathVector(.25, .05));
	     //	_view.setupCamera(_heroEntity, new MathVector(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 1550, 450), new MathVector(.25, .05));
			addEntity(_heroEntity);
			
			var draggableHeroArt:DisplayObject = view.getArt(_view) as DisplayObject;
			draggableHeroArt.addEventListener(MouseEvent.MOUSE_DOWN, _handleGrab);

			stage.addEventListener(MouseEvent.MOUSE_UP, _handleRelease);
			var platform:Platform = new Platform("platform", { x:600, y:350, width:7800, height:20 } );
		//	platform.rotation = 20;
			add(platform);
			
			var enemy:Enemy = new Enemy("enemy", {x:stage.stageWidth - 50, y:350, width:46, height:68, leftBound:20, rightBound:stage.stageWidth - 20});
		//	add(enemy);
			enemy.enemyClass = DraggableHeroPhysicsComponent;
		}
		
		private function _handleGrab(mEvt:MouseEvent):void {

			var clickedObject:CitrusObject = view.getObjectFromArt(mEvt.currentTarget) as CitrusObject;

			if (clickedObject)
				_physics.enableHolding(mEvt.currentTarget.parent);
		}

		private function _handleRelease(mEvt:MouseEvent):void {
			_physics.disableHolding();
		}

	}
}
