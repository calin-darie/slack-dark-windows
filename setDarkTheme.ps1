$latestSlackDir = `
    [IO.Path]::Combine( `
		[Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData), `
		"slack") | `
    Get-ChildItem -Directory -Filter "app-*" | `
	sort CreationTime -Descending | `
	Select -First 1

$fileToPatch = [IO.Path]::Combine($latestSlackDir.FullName, `
    'resources', 'app.asar.unpacked', 'src', 'static', 'ssb-interop.js')

$themeDir = [IO.Path]::Combine($latestSlackDir.FullName, `
    'resources', 'themes')
New-Item -ItemType Directory -Force $themeDir

$themeCssPath = [IO.Path]::Combine($PSScriptRoot, 'black.css')
Copy-Item $themeCssPath $themeDir

$currentContent = [IO.File]::ReadAllText($fileToPatch)

$scriptToAppend = [IO.File]::ReadAllText([IO.Path]::Combine($PSScriptRoot, 'scriptToAppend.js'))

if (-not $currentContent.Contains($scriptToAppend)) {
	Add-Content $fileToPatch $scriptToAppend
}