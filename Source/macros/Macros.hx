package macros;
#if macro

import api.*;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.Template;
import sys.io.FileInput;
import sys.io.File;
import sys.FileSystem;

/**
 * ...
 * @author TBaudon
 */
class Macros
{

	macro public static function generateNodes() {
		trace('Parsing nodes...');
		
		var classesToParse : Array<Class<Dynamic>> = new Array<Class<Dynamic>>();
		
		classesToParse.push(API_Math);
		classesToParse.push(API_Value);
		
		for (currentClass in classesToParse) {
			
			var className = Type.getClassName(currentClass).split('.')[1];
			trace(className);
			
			var input : FileInput = getFile(className);
			parseCode(input, className);
		}
		
		trace('Nodes generated.');
		return macro {};
	}
	
	static public function getFile(className:String) : FileInput
	{
		var p  = Context.resolvePath("api/"+className+".hx");
		return File.read(p);
	}
	
	static public function parseCode(file : FileInput, className : String) {
		var line : String;
		while (!file.eof()) {
			line = file.readLine();
			if (line.indexOf('function') != -1) {
				var inputs : Array<{name:String, type:String}> = getFunctionParams(line);
				var outputs : Array<{name:String, type:String}> = getFunctionReturnType(line);
				var nodeName = getFunctionName(line);
				generateNode(inputs, outputs, nodeName, className);
			}
		}
	}
	
	static public function getFunctionParams(line : String) : Array<{name:String, type:String}>{
		var startIndex = line.indexOf('(') + 1;
		var endIndex = line.indexOf(')');
		var parameters : String = line.substr(startIndex, endIndex - startIndex);
		
		var params = new Array<{name:String, type:String}>();
		
		if(parameters.length>3){
			var paramsStr = parameters.split(',');
			for (param in paramsStr) {
				var pname = param.split(':')[0];
				pname = StringTools.replace(pname, ' ', '');
				var ptype = param.split(':')[1];
				ptype = StringTools.replace(ptype, ' ', '');
				params.push( { name:pname, type:ptype } );
			}
		}
		
		return params;
	}
	
	static public function getFunctionReturnType(line:String) : Array<{name:String, type:String}> {
		var startIndex = line.indexOf(')') + 1;
		var returnPart = line.substr(startIndex);
		returnPart = StringTools.replace(returnPart, ' ', '');
		returnPart = StringTools.replace(returnPart, '{', '');
		returnPart = StringTools.replace(returnPart, '}', '');
		
		var returns = new Array<{name:String, type:String}>();
		
		if (returnPart.indexOf(':') != -1) {
			returnPart = returnPart.substr(1);
			
			var types = returnPart.split(',');
			if (types.length == 1) returns.push( { type:returnPart, name:returnPart } );
			else {
				for (type in types) {
					var returnName = type.split(':')[0];
					returnName = StringTools.replace(returnName, ' ', '');
					var returnType = type.split(':')[1];
					returnType = StringTools.replace(returnType, ' ', '');
					returns.push( { type:returnType, name:returnName } );
				}
			}
		}
		return returns;
	}
	
	static public function getFunctionName(line:String) : String {
		var lastPos = line.indexOf('(');
		var firstPos = line.indexOf('function') + 'function'.length;
		var name = line.substr(firstPos, lastPos - firstPos);
		return name;
	}
	
	static function generateNode(
	_inputs : Array<{name:String, type:String}>, 
	_outputs:Array<{name:String, type:String}>, 
	_nodeName : String, dir : String) {
		
		var apiName = dir;
		dir = dir.toLowerCase();
		_nodeName = StringTools.replace(_nodeName, ' ', '');
		
		var paramList : String = "";
		for (param in _inputs) 
			paramList += param.name +", ";
		paramList = paramList.substr(0, paramList.length - 2);
		
		var file = File.getContent("Res/NodeTemplate.hx");
		var t = new Template(file);
		
		var node = { inputs:_inputs, 
		outputs:_outputs, nodeName: "Node_" + _nodeName, 
		npackage: 'nodes.' + dir, api:apiName, func:_nodeName,
		params:paramList, multiplout:_outputs.length>1};
		
		var out = t.execute(node);
		
		var dirPath = 'nodes/' + dir;
		FileSystem.createDirectory(dirPath);
		
		var fname = "nodes/"+dir+"/Node_"+_nodeName + ".hx";
		var fout = File.write(fname, false);
		fout.writeString(out);
		fout.close();
	}
	
}
#end