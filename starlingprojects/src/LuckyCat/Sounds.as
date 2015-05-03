/**
 *
 * Hungry Hero Game
 * http://www.hungryherogame.com
 *
 * Copyright (c) 2012 Hemanth Sharma (www.hsharma.com). All rights reserved.
 *
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
 *
 */

package LuckyCat
{
	
	import flash.media.Sound;
	
	/**
	 * This class holds all the sound embeds and objects that are used in the game.
	 *
	 * @author hsharma
	 *
	 */
	public class Sounds
	{
		/**
		 * Embedded sound files.
		 */
		
		[Embed(source="Sounds/shootsound.mp3")]
		public static const SND_SHOOT:Class;
		[Embed(source="Sounds/startsound.mp3")]
		public static const SND_START:Class;
		
		/**
		 * Initialized Sound objects.
		 *
		 */
		
		public static var sndStart:Sound = new Sounds.SND_START() as Sound;
		public static var sndShoot:Sound = new Sounds.SND_SHOOT() as Sound;
		
		/**
		 * Sound mute status.
		 */
		public static var muted:Boolean = false;
	}
}