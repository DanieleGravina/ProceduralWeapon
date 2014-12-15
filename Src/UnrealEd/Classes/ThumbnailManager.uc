/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * This class contains a list of thumbnail rendering entries, which can be
 * configured from Editor.ini. The idea is for thumbnail rendering to be
 * extensible without having to modify Epic code.
 */
class ThumbnailManager extends Object
	native
	config(Editor);

/**
 * Types of primitives for drawing thumbnails of resources.
 */
enum EThumbnailPrimType
{
	TPT_None,
	TPT_Sphere,
	TPT_Cube,
	TPT_Plane,
	TPT_Cylinder
};

/**
* Types of backgrounds to use for rendering thumbnails
*/
enum EThumbnailBackgroundType
{
	TBT_None,
	TBT_DefaultBackground,
	TBT_SolidBackground
};

/**
 * Holds the settings for a class that needs a thumbnail renderer. Each entry
 * maps to a corresponding class and holds the information needed
 * to render the thumbnail, including which object to render via and its
 * border color.
 */
struct native ThumbnailRenderingInfo
{
	/**
	 * The name of the class that this thumbnail is for (so we can lazy bind)
	 */
	var String ClassNeedingThumbnailName;
	/**
	 * This is the class that this entry is for, i.e. the class that
	 * will be rendered in the thumbnail views
	 */
	var Class ClassNeedingThumbnail;
	/**
	 * The name of the class to load when rendering this thumbnail
	 * NOTE: This is a string to avoid any dependencies of compilation
	 */
	var String RendererClassName;
	/**
	 * The instance of the renderer class
	 */
	var ThumbnailRenderer Renderer;
	/**
	 * The name of the class to load when rendering labels for this thumbnail
	 * NOTE: This is a string to avoid any dependencies of compilation
	 */
	var String LabelRendererClassName;
	/**
	 * The instance of the label renderer class
	 */
	var ThumbnailLabelRenderer LabelRenderer;
	/**
	 * This is the border color to use for this type
	 */
	var Color BorderColor;
	/**
	 * Icon for objects that don't have specialized drawing needs but still
	 * want to be able to see a thumbnail
	 */
	var String IconName;
};

/**
 * The array of thumbnail rendering information entries. Each type that supports
 * thumbnail rendering has an entry in here.
 */
var const config array<ThumbnailRenderingInfo> RenderableThumbnailTypes;

/**
 * The array of thumbnail rendering information entries which support archetypes. Each type that supports
 * archetype thumbnail rendering must have an entry in the .ini file.
 */
var const config array<ThumbnailRenderingInfo> ArchetypeRenderableThumbnailTypes;

/**
 * Determines whether the initialization function is needed or not
 */
var const bool bIsInitialized;

// The following members are present for performance optimizations

/**
 * Whether to update the map or not (GC usually causes this)
 */
var const bool bMapNeedsUpdate;

/**
 * This holds a map of object type to render info entries
 */
var private{private} native transient const pointer RenderInfoMap;

/**
 * This holds a map of object type to render info entries for archetypes
 */
var private{private} native transient const pointer ArchetypeRenderInfoMap{TMap<UClass *,FThumbnailRenderingInfo *>};

/**
 * The render info to share across all object types when the object doesn't
 * support rendering of thumbnails
 */
var const ThumbnailRenderingInfo NotSupported;

/**
 * Cached background component instead of creating and destroying them for each
 * thumbnail that is rendered
 */
var const StaticMeshComponent BackgroundComponent;

/**
 * Cached static mesh component instead of creating and destroying them for
 * each thumbnail that is rendered
 */
var const StaticMeshComponent SMPreviewComponent;

/**
 * Cached skeletal mesh component instead of creating and destroying them for
 * each thumbnail that is rendered
 */
var const SkeletalMeshComponent SKPreviewComponent;

/**
 *	When TRUE, ParticleSystem thumbnails will render a real-time preview
 */
var bool bPSysRealTime;

// All these meshes/materials/textures are preloaded via default properties

var const StaticMesh TexPropCube;
var const StaticMesh TexPropSphere;
var const StaticMesh TexPropCylinder;
var const StaticMesh TexPropPlane;
var const Material ThumbnailBackground;
var const Material ThumbnailBackgroundSolid;
var const MaterialInstanceConstant ThumbnailBackgroundSolidMatInst;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   RenderableThumbnailTypes(0)=(ClassNeedingThumbnailName="Engine.Prefab",RendererClassName="UnrealEd.PrefabThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=128,G=192,R=255,A=255),IconName="EngineResources.UnrealEdIcon_Prefab")
   RenderableThumbnailTypes(1)=(ClassNeedingThumbnailName="Engine.PhysicsAsset",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.PhysicsAssetLabelRenderer",BorderColor=(B=128,G=192,R=255,A=255),IconName="EngineResources.UnrealEdIcon_PhysAsset")
   RenderableThumbnailTypes(2)=(ClassNeedingThumbnailName="Engine.PhysicalMaterial",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=255,G=0,R=0,A=255),IconName="EngineMaterials.UnrealEdIcon_PhysMat")
   RenderableThumbnailTypes(3)=(ClassNeedingThumbnailName="Engine.AnimTree",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.AnimTreeLabelRenderer",BorderColor=(B=192,G=128,R=255,A=255),IconName="EngineMaterials.UnrealEdIcon_AnimTree")
   RenderableThumbnailTypes(4)=(ClassNeedingThumbnailName="Engine.SoundNodeWave",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.SoundLabelRenderer",BorderColor=(B=255,G=0,R=0,A=255),IconName="EngineResources.UnrealEdIcon_Sound")
   RenderableThumbnailTypes(5)=(ClassNeedingThumbnailName="Engine.SoundCue",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.SoundLabelRenderer",BorderColor=(B=255,G=175,R=0,A=255),IconName="EngineResources.UnrealEdIcon_SoundCue")
   RenderableThumbnailTypes(6)=(ClassNeedingThumbnailName="Engine.SpeechRecognition",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=255,G=0,R=0,A=255),IconName="EngineResources.UnrealEdIcon_SoundCue")
   RenderableThumbnailTypes(7)=(ClassNeedingThumbnailName="Engine.Font",RendererClassName="UnrealEd.FontThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=255,G=0,R=0,A=255),IconName="EngineResources.UnrealEdIcon_Font")
   RenderableThumbnailTypes(8)=(ClassNeedingThumbnailName="Engine.Sequence",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=255,G=255,R=255,A=255),IconName="EngineMaterials.UnrealEdIcon_Sequence")
   RenderableThumbnailTypes(9)=(ClassNeedingThumbnailName="Engine.AnimSet",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.AnimSetLabelRenderer",BorderColor=(B=255,G=128,R=192,A=255),IconName="EngineMaterials.UnrealEdIcon_AnimSet")
   RenderableThumbnailTypes(10)=(ClassNeedingThumbnailName="Engine.TerrainMaterial",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=192,G=255,R=192,A=255),IconName="EngineResources.UnrealEdIcon_TerrainMaterial")
   RenderableThumbnailTypes(11)=(ClassNeedingThumbnailName="Engine.TerrainLayerSetup",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=255,G=192,R=128,A=255),IconName="EngineResources.UnrealEdIcon_TerrainLayerSetup")
   RenderableThumbnailTypes(12)=(ClassNeedingThumbnailName="Engine.Texture2D",RendererClassName="UnrealEd.TextureThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(13)=(ClassNeedingThumbnailName="Engine.ShadowMap2D",RendererClassName="UnrealEd.TextureThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(14)=(ClassNeedingThumbnailName="Engine.ShadowMapTexture2D",RendererClassName="UnrealEd.TextureThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(15)=(ClassNeedingThumbnailName="Engine.TextureRenderTarget",RendererClassName="UnrealEd.TextureThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(16)=(ClassNeedingThumbnailName="Engine.TextureRenderTargetCube",RendererClassName="UnrealEd.TextureThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(17)=(ClassNeedingThumbnailName="Engine.TextureFlipBook",RendererClassName="UnrealEd.TextureThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(18)=(ClassNeedingThumbnailName="Engine.TextureMovie",RendererClassName="UnrealEd.TextureThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(19)=(ClassNeedingThumbnailName="Engine.LightMapTexture2D",RendererClassName="UnrealEd.TextureThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(20)=(ClassNeedingThumbnailName="Engine.TextureCube",RendererClassName="UnrealEd.TextureCubeThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=0,R=255,A=255))
   RenderableThumbnailTypes(21)=(ClassNeedingThumbnailName="Engine.Material",RendererClassName="UnrealEd.MaterialInstanceThumbnailRenderer",LabelRendererClassName="UnrealEd.MaterialInstanceLabelRenderer",BorderColor=(B=0,G=255,R=0,A=255))
   RenderableThumbnailTypes(22)=(ClassNeedingThumbnailName="Engine.MaterialInterface",RendererClassName="UnrealEd.MaterialInstanceThumbnailRenderer",LabelRendererClassName="UnrealEd.MaterialInstanceLabelRenderer",BorderColor=(B=0,G=128,R=0,A=255))
   RenderableThumbnailTypes(23)=(ClassNeedingThumbnailName="Engine.ParticleSystem",RendererClassName="UnrealEd.ParticleSystemThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=255,R=255,A=255))
   RenderableThumbnailTypes(24)=(ClassNeedingThumbnailName="Engine.StaticMesh",RendererClassName="UnrealEd.StaticMeshThumbnailRenderer",LabelRendererClassName="UnrealEd.StaticMeshLabelRenderer",BorderColor=(B=255,G=255,R=0,A=255))
   RenderableThumbnailTypes(25)=(ClassNeedingThumbnailName="Engine.SkeletalMesh",RendererClassName="UnrealEd.SkeletalMeshThumbnailRenderer",LabelRendererClassName="UnrealEd.SkeletalMeshLabelRenderer",BorderColor=(B=255,G=0,R=255,A=255))
   RenderableThumbnailTypes(26)=(ClassNeedingThumbnailName="Engine.MorphTargetSet",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=128,R=192,A=255),IconName="EngineMaterials.UnrealEdIcon_MorphTargetSet")
   RenderableThumbnailTypes(27)=(ClassNeedingThumbnailName="Engine.MorphWeightSequence",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=192,R=128,A=255),IconName="EngineMaterials.UnrealEdIcon_MorphWeightSequence")
   RenderableThumbnailTypes(28)=(ClassNeedingThumbnailName="Engine.PostProcessChain",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.PostProcessLabelRenderer",BorderColor=(B=255,G=128,R=192,A=255),IconName="EngineMaterials.UnrealEdIcon_PostProcessChain")
   RenderableThumbnailTypes(29)=(ClassNeedingThumbnailName="Engine.UIScene",RendererClassName="UnrealEd.UISceneThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=200,G=170,R=30,A=255),IconName="EngineResources.UnrealEdIcon_Archetype")
   RenderableThumbnailTypes(30)=(ClassNeedingThumbnailName="Engine.CurveEdPresetCurve",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=200,G=170,R=30,A=255),IconName="EngineMaterials.UnrealEdIcon_CurveEdPresetCurve")
   RenderableThumbnailTypes(31)=(ClassNeedingThumbnailName="Engine.FaceFXAsset",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=0,G=192,R=255,A=255),IconName="EngineResources.UnrealEdIcon_FaceFXAsset")
   RenderableThumbnailTypes(32)=(ClassNeedingThumbnailName="Engine.FaceFXAnimSet",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=255,G=128,R=128,A=255),IconName="EngineResources.UnrealEdIcon_FaceFXAsset")
   RenderableThumbnailTypes(33)=(ClassNeedingThumbnailName="Engine.UISkin",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=150,G=125,R=15,A=255),IconName="EngineResources.UnrealEdIcon_Archetype")
   RenderableThumbnailTypes(34)=(ClassNeedingThumbnailName="Engine.CameraAnim",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=150,G=125,R=15,A=255),IconName="EngineResources.UnrealEdIcon_Archetype")
   RenderableThumbnailTypes(35)=(ClassNeedingThumbnailName="Engine.SpeedTree",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=64,G=255,R=64,A=255),IconName="EditorResources.SpeedTreeLogoBig")
   RenderableThumbnailTypes(36)=(ClassNeedingThumbnailName="Engine.LensFlare",RendererClassName="UnrealEd.LensFlareThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=64,G=200,R=255,A=255))
   RenderableThumbnailTypes(37)=(ClassNeedingThumbnailName="UTGame.UTMapMusicInfo",RendererClassName="UnrealEd.IconThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=255,G=0,R=0,A=255))
   ArchetypeRenderableThumbnailTypes(0)=(ClassNeedingThumbnailName="Core.Object",RendererClassName="UnrealEd.ArchetypeThumbnailRenderer",LabelRendererClassName="UnrealEd.GenericThumbnailLabelRenderer",BorderColor=(B=128,G=192,R=255,A=255),IconName="EngineResources.UnrealEdIcon_Archetype")
   bMapNeedsUpdate=True
   bPSysRealTime=True
   TexPropCube=StaticMesh'EditorMeshes.TexPropCube'
   TexPropSphere=StaticMesh'EditorMeshes.TexPropSphere'
   TexPropCylinder=StaticMesh'EditorMeshes.TexPropCylinder'
   TexPropPlane=StaticMesh'EditorMeshes.TexPropPlane'
   ThumbnailBackground=Material'EditorMaterials.ThumbnailBack'
   ThumbnailBackgroundSolid=Material'EditorMaterials.ThumbnailSolid'
   ThumbnailBackgroundSolidMatInst=MaterialInstanceConstant'EditorMaterials.ThumbnailSolid_MATInst'
   Name="Default__ThumbnailManager"
   ObjectArchetype=Object'Core.Default__Object'
}
