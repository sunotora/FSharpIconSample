$oldString="<expiration maximumAge=`"0`" unit=`"days`" />"
$newString="<beforeApplicationStartup />"

$text=Get-Content $args[0]
if ($text -match $oldString)
{
    $conv=$text -replace $oldString, $newString
    set-content $args[0] -value $conv
}
