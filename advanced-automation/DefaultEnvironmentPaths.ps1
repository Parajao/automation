$paths = 
	"$env:programFiles\Git\bin",
	"$env:programFiles\Git\usr\bin",
	"$env:programFiles\Microsoft VS Code",
	"${env:programFiles(x86)}\Google\Chrome\Application\", 
	"$env:USERPROFILE\AppData\Local\BraveSoftware\Brave-Browser\Application",
	"$env:winDir\System32\inetsrv", 
	"$env:USERPROFILE\AppData\Local\slack\",
	"${env:programFiles(x86)}\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin",
	"${env:programFiles(x86)}\TeamViewer",
	"${env:programFiles(x86)}\nunit.org\nunit-console\",
	"$env:USERPROFILE\AppData\Local\Postman",
	"$env:programFiles\curl\bin",

$paths | % {
	if(-not (($env:path -split ';') -contains $_)) {
		$env:path += ';' + $_
	}
}