Class constructor
	C_OBJECT:C1216($1)
	This:C1470.align:=$1.align
	
Function onInvoke
	C_OBJECT:C1216($1;$0)
	C_BOOLEAN:C305($okProcess)
	C_OBJECT:C1216($ob)
	C_TEXT:C284($objectName;$obType)
	C_LONGINT:C283($left;$top;$right;$bottom;$r;$b)
	C_LONGINT:C283($width;$height)
	C_COLLECTION:C1488($objects)
	var $helper : cs.FormMacroHelper
	
	$helper:=cs:C1710.FormMacroHelper.new($1)
	
	If ($helper.GetSelectedObjectCount()>1)
		$okProcess:=False:C215
		$objects:=New collection:C1472
		
		For each ($objectName;$helper.GetSelection())
			$ob:=$helper.GetFormObject($objectName;-1;->$obType)
			$objects.push($ob)
		End for each 
		
		Case of 
				
			: (This:C1470.align="left")
				$left:=MAXLONG:K35:2
				For each ($ob;$objects)
					If ($left>$ob.left)
						$left:=$ob.left
					End if 
				End for each 
				
				For each ($ob;$objects)
					$helper.ObjectSetX($ob;$left)
				End for each 
				$okProcess:=True:C214
				
			: (This:C1470.align="top")
				$top:=MAXLONG:K35:2
				For each ($ob;$objects)
					If ($top>$ob.top)
						$top:=$ob.top
					End if 
				End for each 
				
				For each ($ob;$objects)
					$helper.ObjectSetY($ob;$top)
				End for each 
				$okProcess:=True:C214
				
			: (This:C1470.align="right")
				$right:=-MAXLONG:K35:2
				For each ($ob;$objects)
					$r:=$helper.ObjectGetRight($ob)
					If ($right<$r)
						$right:=$r
					End if 
				End for each 
				
				For each ($ob;$objects)
					$helper.ObjectSetX($ob;$right-$helper.ObjectGetWidth($ob))
				End for each 
				$okProcess:=True:C214
				
			: (This:C1470.align="bottom")
				$bottom:=-MAXLONG:K35:2
				For each ($ob;$objects)
					$b:=$helper.ObjectGetBottom($ob)
					If ($bottom<$b)
						$bottom:=$b;
					End if 
				End for each 
				
				For each ($ob;$objects)
					$helper.ObjectSetY($ob;$bottom-$helper.ObjectGetHeight($ob))
				End for each 
				$okProcess:=True:C214
		End case 
		
		If ($okProcess)
			$0:=New object:C1471
			OB SET:C1220($0;"currentPage";$1.editor.currentPage)
		End if 
		
		CLEAR VARIABLE:C89($objects)
		
	Else 
		BEEP:C151
	End if 
	
	
	