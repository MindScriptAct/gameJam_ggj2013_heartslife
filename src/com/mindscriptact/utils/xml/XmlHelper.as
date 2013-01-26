package com.mindscriptact.utils.xml {
import flash.utils.describeType;
import flash.utils.getDefinitionByName;

/**
 * TODO:CLASS COMMENT
 * @author Raimundas Banevicius (raima156@yahoo.com)
 */
public class XmlHelper {
	
	static public function fillObjectWithXml(fillClass:Class, xmlFile:XML):Object {
		var retval:Object = new fillClass();
		xmlToObject(retval, xmlFile);
		return retval;
	}
	
	static public function xmlToObject(fillObject:Object, xmlFile:XML):void {
		var subList:XMLList;
		
		var classDescription:XML = describeType(fillObject.constructor);
		
		var variableList:XMLList = classDescription.factory.*.(name() == "variable" || name() == "accessor");
		
		for (var i:int = 0; i < variableList.length(); i++) {
			// check if its vertor
			
			var variableType:String = variableList[i].@type;
			
			if (variableType.indexOf("__AS3__.vec::Vector") != -1) {
				//trace("vector variableType : " + variableType);
				//handle as collection of items.
				
				var vectorHolderList:XMLList = xmlFile[variableList[i].@name];
				
				var childSplitArr:Array = variableType.split("<");
				
				var childType:String = childSplitArr[childSplitArr.length - 1].split(">")[0];
				var clildClass:Class = getDefinitionByName(childType) as Class;
				
				if (vectorHolderList.length() == 1) {
					var vectorItimList:XMLList = vectorHolderList[0].children();
					for (var j:int = 0; j < vectorItimList.length(); j++) {
						var childObject:Object = new clildClass();
						
						xmlToObject(childObject, vectorItimList[j])
						
						fillObject[variableList[i].@name].push(childObject);
					}
				} else if (vectorHolderList.length() > 1) {
					// treat nodes AS object elements.
					for (var k:int = 0; k < vectorHolderList.length(); k++) {
						childObject = new clildClass();
						xmlToObject(childObject, vectorHolderList[k])
						fillObject[variableList[i].@name].push(childObject);
					}
				}
				
			} else {
				//trace("variableType : " + variableType);
				var memberValue:Object;
				switch (variableType) {
					case "Boolean": 
						memberValue = String(xmlFile["@" + variableList[i].@name]);
						if (memberValue == "") {
							subList = xmlFile[variableList[i].@name];
							if (subList.length() == 1) {
								memberValue = (subList[0] as XML).toString() == "true" || (subList[0] as XML).toString() == "TRUE"
							}
						}
						if (memberValue == null || memberValue == "" || memberValue == "0" || memberValue == "false" || memberValue == "null" || memberValue == "NaN" || memberValue == "False" || memberValue == "FALSE") {
							memberValue = false;
						} else {
							memberValue = true;
						}
						// ???
						break;
					case "int": 
						memberValue = int(xmlFile["@" + variableList[i].@name]);
						if (memberValue == 0) {
							subList = xmlFile[variableList[i].@name];
							if (subList.length() == 1) {
								memberValue = int((subList[0] as XML).toString());
							}
						}
						break;
					case "uint": 
						memberValue = uint(xmlFile["@" + variableList[i].@name]);
						if (memberValue == 0) {
							subList = xmlFile[variableList[i].@name];
							if (subList.length() == 1) {
								memberValue = uint((subList[0] as XML).toString());
							}
						}
						break;
					case "Number": 
						memberValue = Number(xmlFile["@" + variableList[i].@name]);
						if (memberValue == 0) {
							subList = xmlFile[variableList[i].@name];
							if (subList.length() == 1) {
								memberValue = Number((subList[0] as XML).toString());
							}
						}
						break;
					case "String": 
						memberValue = String(xmlFile["@" + variableList[i].@name]);
						if (memberValue == "") {
							subList = xmlFile[variableList[i].@name];
							if (subList.length() == 1) {
								memberValue = (subList[0] as XML).toString();
							}
						}
						break;
					default: 
						var objectClass:Class = getDefinitionByName(variableType) as Class;
						if (objectClass) {
							memberValue = new objectClass();
							var objectNodes:XMLList = xmlFile[variableList[i].@name];
							if (objectNodes.length() > 0) {
								xmlToObject(memberValue, objectNodes[0]);
							}
						} else {
							throw Error("cant handle this type: " + variableType);
						}
				}
				fillObject[variableList[i].@name] = memberValue;
			}
		}
	}
}
}
