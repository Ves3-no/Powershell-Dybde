#$myList1=[System.Collections.ArrayList]@()
$myList2=New-Object -TypeName System.Collections.ArrayList

$myIndex = $myList2.Add("Test1")
[void]$myList2.Add("Test2")

$myList2.Count

$myIndex

$myList2.AddRange(@("Test3", "Test4")) #RemoveRange fungerer også(med index)

$myList2.RemoveAt($myIndex)

$myList2.Remove("Test4") #Bare først i Listen

$myList2