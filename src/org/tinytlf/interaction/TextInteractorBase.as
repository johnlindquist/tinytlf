package org.tinytlf.interaction
{
  import org.tinytlf.ITextEngine;
  import org.tinytlf.utils.Type;
  
  import flash.events.EventDispatcher;
  import flash.events.IEventDispatcher;
  
  import mx.core.IFactory;
  
  public class TextInteractorBase extends TextDispatcherBase implements ITextInteractor
  {
    public function TextInteractorBase()
    {
      super(null);
    }
    
    protected var _engine:ITextEngine;
    public function get engine():ITextEngine
    {
      return _engine;
    }
    
    public function set engine(textEngine:ITextEngine):void
    {
      if(textEngine == _engine)
        return;
      
      _engine = textEngine;
    }
    
    public function getMirror(elementName:String = ""):EventDispatcher
    {
      var mirror:Object = mirrorMap[elementName];
      
      if(!mirror)
        return this;
      
      if(mirror is Class)
        return new(mirror as Class)() as EventDispatcher;
      
      if(mirror is IFactory)
        return IFactory(mirror).newInstance() as EventDispatcher;
      
      if(mirror is Function)
        return (mirror as Function)() as EventDispatcher;
      
      return mirror as EventDispatcher;
    }
    
    private var mirrorMap:Object = {};
    public function mapMirror(elementName:String, mirrorClassOrInstance:Object):void
    {
      mirrorMap[elementName] = mirrorClassOrInstance;
    }
    
    public function unMapMirror(elementName:String):Boolean
    {
      if(elementName in mirrorMap)
        return delete mirrorMap[elementName];
      
      return false;
    }
  }
}