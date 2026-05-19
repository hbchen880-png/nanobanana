; Inno Setup script
#define MyAppName "NanoBanana 图片生成工具"
#define MyAppVersion "24"
#define MyAppPublisher "OpenAI"
#define MyAppExeName "NanoBananaImageGenerator.exe"

[Setup]
AppId={{E4D6A90E-8DAB-4878-93D2-B572A3F0A0C1}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\NanoBananaImageGenerator
DefaultGroupName=NanoBanana 图片生成工具
DisableProgramGroupPage=yes
OutputDir=installer_dist
OutputBaseFilename=NanoBananaImageGenerator_Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "dist\NanoBananaImageGenerator.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\NanoBanana 图片生成工具"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\NanoBanana 图片生成工具"; Filename: "{app}\{#MyAppExeName}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "启动 NanoBanana 图片生成工具"; Flags: nowait postinstall skipifsilent
