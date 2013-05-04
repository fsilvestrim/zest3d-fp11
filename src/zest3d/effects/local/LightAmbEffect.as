package zest3d.effects.local 
{
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.Material;
	import zest3d.shaderfloats.light.LightAmbientConstant;
	import zest3d.shaderfloats.light.LightAttenuationConstant;
	import zest3d.shaderfloats.material.MaterialAmbientConstant;
	import zest3d.shaderfloats.material.MaterialEmissiveConstant;
	import zest3d.shaderfloats.matrix.PVWMatrixConstant;
	import zest3d.shaders.enum.VariableSemanticType;
	import zest3d.shaders.enum.VariableType;
	import zest3d.shaders.PixelShader;
	import zest3d.shaders.states.AlphaState;
	import zest3d.shaders.states.CullState;
	import zest3d.shaders.states.DepthState;
	import zest3d.shaders.states.OffsetState;
	import zest3d.shaders.states.StencilState;
	import zest3d.shaders.states.WireState;
	import zest3d.shaders.VertexShader;
	import zest3d.shaders.VisualEffect;
	import zest3d.shaders.VisualEffectInstance;
	import zest3d.shaders.VisualPass;
	import zest3d.shaders.VisualTechnique;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class LightAmbEffect extends VisualEffect implements IDisposable 
	{
		
		public static const msAGALVRegisters: Array = [ 0, 1 ];
		
		public static const msVRegisters: Array =
		[
			null,
			msAGALVRegisters,
			null,
			null,
			null
		];
		
		public static const msVPrograms: Array =
		[
			"",
			// AGAL_1_0
			"",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		public static const msPPrograms: Array =
		[
			"",
			// AGAL_1_0
			"",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		public function LightAmbEffect( ) 
		{
			var vShader: VertexShader = new VertexShader( "Zest3D.LightAmb", 1, 2, 5, 0, false );
			vShader.setInput( 0, "modelPosition", VariableType.FLOAT3, VariableSemanticType.POSITION );
			vShader.setOutput( 0, "clipPosition", VariableType.FLOAT4, VariableSemanticType.POSITION );
			vShader.setOutput( 1, "vertexColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			vShader.setConstant( 0, "PVWMatrix", 4 );
			vShader.setConstant( 1, "MaterialEmissive", 1 );
			vShader.setConstant( 2, "MaterialAmbient", 1 );
			vShader.setConstant( 3, "LightAmbient", 1 );
			vShader.setConstant( 4, "LightAttenuation", 1 );
			vShader.setBaseRegisters( msVRegisters );
			vShader.setPrograms( msVPrograms );
			
			var pShader: PixelShader = new PixelShader( "Zest3D.LightAmb", 1, 1, 0, 0, false );
			pShader.setInput( 0, "vertexColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			pShader.setOutput( 0, "pixelColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			pShader.setPrograms( msPPrograms );
			
			var pass: VisualPass = new VisualPass();
			pass.vertexShader = vShader;
			pass.pixelShader = pShader;
			pass.alphaState = new AlphaState();
			pass.cullState = new CullState();
			pass.depthState = new DepthState();
			pass.offsetState = new OffsetState();
			pass.stencilState = new StencilState();
			pass.wireState = new WireState();
			
			var technique: VisualTechnique = new VisualTechnique();
			technique.insertPass( pass );
			insertTechnique( technique );
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
		public function createInstance( light: Light, material: Material ): VisualEffectInstance
		{
			var instance: VisualEffectInstance = new VisualEffectInstance( this, 0 );
			instance.setVertexConstantByHandle( 0, 0, new PVWMatrixConstant() );
			instance.setVertexConstantByHandle( 0, 1, new MaterialEmissiveConstant( material ) );
			instance.setVertexConstantByHandle( 0, 2, new MaterialAmbientConstant( material ) );
			instance.setVertexConstantByHandle( 0, 3, new LightAmbientConstant( light ) );
			instance.setVertexConstantByHandle( 0, 4, new LightAttenuationConstant( light ) );
			
			return instance;
		}
		
		public static function creatUniqueInstance( light: Light, material: Material ): VisualEffectInstance
		{
			var effect: LightAmbEffect = new LightAmbEffect();
			return effect.createInstance( light, material );
		}
		
	}

}