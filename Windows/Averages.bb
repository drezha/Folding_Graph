FILENAME$ = "output.csv"
TEMP$ = "temp.csv"

file = ReadFile(FILENAME$)
file2 = WriteFile(TEMP$)

While Not Eof(file)
	lin$ = ReadLine$(file)
	count%=0
	For i%= 0 To Len(lin$)
		If Mid$(lin$,i%,1) = "," count=count+1
	Next
	If count<4	Then ;Average not yet computed	
		com1% = Instr (lin$,",")
		com2% = Instr (lin$,",",com1%+1)
		com3% = Instr (lin$,",",com2%+1)
		
		b% = Mid$(lin$,com1%+1,com2%-com1%-1)
		c% = Mid$(lin$,com2%+1,com3%-com2%-1)
		
		If b%=0 Then
			avg% = 0
		Else
			avg% = Ceil(c%/Float(b%))
		EndIf
		WriteLine file2,lin$+","+avg
	Else
		WriteLine file2,lin$
	EndIf
Wend

CloseFile(file)
CloseFile(file2)
Delay 300
DeleteFile FILENAME$
CopyFile TEMP$, FILENAME$
DeleteFile TEMP$