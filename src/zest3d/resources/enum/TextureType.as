/**
 * Plugin.IO - http://www.plugin.io
 * Copyright (c) 2011-2012
 *
 * Geometric Tools, LLC
 * Copyright (c) 1998-2012
 * 
 * Distributed under the Boost Software License, Version 1.0.
 * http://www.boost.org/LICENSE_1_0.txt
 */
package zest3d.resources.enum 
{
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class TextureType 
	{
		
		public static const TEXTURE_1D: TextureType = new TextureType( "texture1D", 0 )
		public static const TEXTURE_2D: TextureType = new TextureType( "texture2D", 1 )
		public static const TEXTURE_3D: TextureType = new TextureType( "texture3D", 2 )
		public static const TEXTURE_CUBE: TextureType = new TextureType( "textureCube", 3 )
		
		public static const QUANTITY: int = 4;
		
		protected var _type: String;
		protected var _index: int;
		public function TextureType( type: String, index: int ) 
		{
			_type = type;
			_index = index;
		}
		
		public static function toVector(): Vector.<TextureType>
		{
			return Vector.<TextureType>
			([
				TEXTURE_1D,
				TEXTURE_2D,
				TEXTURE_3D,
				TEXTURE_CUBE
			]);
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get index():int 
		{
			return _index;
		}
		
	}

}