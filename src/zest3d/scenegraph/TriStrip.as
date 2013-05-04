package zest3d.scenegraph 
{
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.core.system.Assert;
	import zest3d.resources.IndexBuffer;
	import zest3d.resources.VertexBuffer;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.enum.PrimitiveType;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class TriStrip extends Triangles implements IDisposable 
	{
		
		public function TriStrip( vFormat: VertexFormat, vBuffer: VertexBuffer, iBuffer: IndexBuffer ) 
		{
			super( PrimitiveType.TRISTRIP, vFormat, vBuffer, iBuffer );
			Assert.isTrue( _iBuffer.numElements >= _vBuffer.numElements, "Not enough elements for the index buffer." );
			
			//TODO consider a help that can atuo-generate strip indices
			/*
			var numVertices: int = _vBuffer.numElements;
			var iBuffer: IndexBuffer = new IndexBuffer( numVertices, .....
			*/
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
		override public function getTriangleAt(index:int, data:Array):Boolean 
		{
			if ( 0 <= index && index < numTriangles )
			{
				_iBuffer.data.position = index * _iBuffer.elementSize;
				
				if ( _iBuffer.elementSize == 2 )
				{
					
					data[ 0 ] = _iBuffer.data.readShort();
					if ( index & 1 )
					{
						data[ 2 ] = _iBuffer.data.readShort();
						data[ 1 ] = _iBuffer.data.readShort();
					}
					else
					{
						data[ 1 ] = _iBuffer.data.readShort();
						data[ 2 ] = _iBuffer.data.readShort();
					}
				}
				else if ( _iBuffer.elementSize == 4 )
				{
					data[ 0 ] = _iBuffer.data.readInt();
					if ( index & 1 )
					{
						data[ 2 ] = _iBuffer.data.readInt();
						data[ 1 ] = _iBuffer.data.readInt();
					}
					else
					{
						data[ 1 ] = _iBuffer.data.readInt();
						data[ 2 ] = _iBuffer.data.readInt();
					}
				}
				else
				{
					throw new Error( "Unsupported element size." );
				}
				
				return ( data[ 0 ] != data[ 1 ] && data[ 0 ] != data[ 2 ] && data[ 1 ] != data[ 2 ] );
			}
			
			return false;
		}
		
		override public function get numTriangles():int 
		{
			return _iBuffer.numElements - 2;
		}
		
	}

}