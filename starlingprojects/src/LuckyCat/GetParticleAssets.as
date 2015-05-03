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
	
	/**
	 * This class holds all particle files.
	 *
	 * @author hsharma
	 *
	 */
	public class GetParticleAssets
	{
		/**
		 * Particle
		 */
		
		[Embed(source="Media/particle/particle.pex",mimeType="application/octet-stream")]
		public static var rocketParticle:Class;
		
		[Embed(source="Media/particle/texture.png")]
		public static var ParticleTexture:Class;
	}
}
