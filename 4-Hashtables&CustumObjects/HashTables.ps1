"
---------------
"

$myHashTable=@{ #Object/Map i Javascript
    key1=100
    apple=129
    name="Heine"
    key2=$true
}
$myHashTable.Keys
#Ikke i order. Kommer ut ulikt enn laget
"
---------------
"
$myHashTable.Values
"
---------------
"
$myHashTable.apple
$myHashTable["key2"]
"
---------------
"
$myHashTable.Add("Hey", $true)

$myHashTable.Hey
"
---------------
"
$myHashTable["key5"]="wow"
$myHashTable.key6="kult"

$myHashTable
"
---------------
"
#Kan bruke contain / containsKey / ContainsValue for å skjekke om det finnes i Bordet
$myHashTable.Remove("key6")

