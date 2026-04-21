# -*- mode: python ; coding: utf-8 -*-
from PyInstaller.utils.hooks import collect_submodules, collect_data_files, collect_dynamic_libs
import base64
import pathlib
import re
import tempfile

hiddenimports = collect_submodules("PIL") + [
    "PIL._tkinter_finder",
    "tkinter",
    "tkinter.ttk",
    "tkinter.filedialog",
    "tkinter.messagebox",
    "tkinterdnd2",
]

datas = collect_data_files("PIL") + collect_data_files("tkinterdnd2")
binaries = collect_dynamic_libs("PIL") + collect_dynamic_libs("tkinterdnd2")

source_text = pathlib.Path("runninghub_image_generator_gui.py").read_text(encoding="utf-8")
match = re.search(r'EMBEDDED_APP_ICON_ICO_BASE64 = """(.*?)"""', source_text, re.S)
icon_path = None
if match:
    icon_path = pathlib.Path(tempfile.gettempdir()) / "nanobanana_build_icon.ico"
    icon_path.write_bytes(base64.b64decode(match.group(1).encode("ascii")))

a = Analysis(
    ["runninghub_image_generator_gui.py"],
    pathex=[],
    binaries=binaries,
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name="NanoBananaImageGenerator",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,
    console=False,
    icon=str(icon_path) if icon_path else None,
)
