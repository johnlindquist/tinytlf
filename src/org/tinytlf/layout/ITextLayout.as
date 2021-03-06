package org.tinytlf.layout
{
  import flash.text.engine.TextBlock;
  import flash.text.engine.TextLine;
  
  import org.tinytlf.ITextEngine;

  public interface ITextLayout
  {
    function get engine():ITextEngine;
    function set engine(textEngine:ITextEngine):void;
    
    function get containers():Vector.<ITextContainer>;
    
    function addContainer(container:ITextContainer):void;
    function removeContainer(container:ITextContainer):void;
    
    function getContainerForLine(line:TextLine):ITextContainer;
    
    function render(blocks:Vector.<TextBlock>):void;
    
    function getLayoutProperties(block:TextBlock):LayoutProperties;
    function mapLayoutProperties(block:TextBlock, properties:LayoutProperties):void;
    function unMapLayoutProperties(block:TextBlock):Boolean;
  }
}