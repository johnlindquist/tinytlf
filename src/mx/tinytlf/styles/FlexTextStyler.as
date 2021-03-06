package mx.tinytlf.styles
{
  import flash.text.engine.BreakOpportunity;
  import flash.text.engine.CFFHinting;
  import flash.text.engine.DigitCase;
  import flash.text.engine.DigitWidth;
  import flash.text.engine.ElementFormat;
  import flash.text.engine.FontDescription;
  import flash.text.engine.FontLookup;
  import flash.text.engine.FontPosture;
  import flash.text.engine.FontWeight;
  import flash.text.engine.Kerning;
  import flash.text.engine.LigatureLevel;
  import flash.text.engine.RenderingMode;
  import flash.text.engine.TextBaseline;
  import flash.text.engine.TextRotation;
  import flash.text.engine.TypographicCase;
  
  import mx.core.Singleton;
  import mx.styles.CSSStyleDeclaration;
  import mx.styles.IStyleManager2;
  
  import org.tinytlf.styles.TextStyler;
  
  public class FlexTextStyler extends TextStyler
  {
    public function FlexTextStyler()
    {
      super();
    }
    
    private var styleDeclaration:CSSStyleDeclaration;
    
    override public function set styleName(value:String):void
    {
      super.styleName = value;
      
      styleDeclaration = styleManager.getStyleDeclaration(styleName || "") || new CSSStyleDeclaration()
    }
    
    override public function getElementFormat(element:*):ElementFormat
    {
      var mainStyleDeclaration:CSSStyleDeclaration = styleDeclaration || new CSSStyleDeclaration();
      var elementStyleDeclaration:CSSStyleDeclaration = styleManager.getStyleDeclaration(styleMap[element] || "") || new CSSStyleDeclaration();
      
      var reduceBoilerplate:Function = function(style:String, defaultValue:*):*
        {
          return (elementStyleDeclaration.getStyle(style) || mainStyleDeclaration.getStyle(style) || defaultValue);
        }
      
      return new ElementFormat(
        new FontDescription(
        reduceBoilerplate("fontFamily", "_sans"),
        reduceBoilerplate("fontWeight", FontWeight.NORMAL),
        reduceBoilerplate("fontStyle", FontPosture.NORMAL),
        reduceBoilerplate("fontLookup", FontLookup.DEVICE),
        reduceBoilerplate("renderingMode", RenderingMode.CFF),
        reduceBoilerplate("cffHinting", CFFHinting.HORIZONTAL_STEM)
        ),
        reduceBoilerplate("fontSize", 12),
        reduceBoilerplate("color", 0x0),
        reduceBoilerplate("fontAlpha", 1),
        reduceBoilerplate("textRotation", TextRotation.AUTO),
        reduceBoilerplate("dominantBaseLine", TextBaseline.ROMAN),
        reduceBoilerplate("alignmentBaseLine", TextBaseline.USE_DOMINANT_BASELINE),
        reduceBoilerplate("baseLineShift", 0.0),
        reduceBoilerplate("kerning", Kerning.ON),
        reduceBoilerplate("trackingRight", 0.0),
        reduceBoilerplate("trackingLeft", 0.0),
        reduceBoilerplate("locale", "en"),
        reduceBoilerplate("breakOpportunity", BreakOpportunity.AUTO),
        reduceBoilerplate("digitCase", DigitCase.DEFAULT),
        reduceBoilerplate("digitWidth", DigitWidth.DEFAULT),
        reduceBoilerplate("ligatureLevel", LigatureLevel.COMMON),
        reduceBoilerplate("typographicCase", TypographicCase.DEFAULT)
        );
    }
    
    protected function get styleManager():IStyleManager2
    {
      return Singleton.getInstance("mx.styles::IStyleManager2") as IStyleManager2;
    }
  }
}