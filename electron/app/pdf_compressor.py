
import subprocess
import os
import sys
import shutil

def get_ghostscript_path():
    prgmPath = ""
    if os.environ.get("PROGRAMFILES(X86)") is None: #this case is 32bit 
        prgmPath = os.environ.get("PROGRAMFILES")
    else:
        prgmPath = os.environ.get("PROGRAMFILES(X86)")
    pathName = "E9pay\\E9pass Manager\\resources\\app\\dist-python\\bin\\gswin32c.exe"
    gostPath = os.path.join(prgmPath, pathName)
    if os.path.isfile(gostPath):
        return gostPath
    raise FileNotFoundError(f'No GhostScript executable was found on path')


def compress(input_file_path, output_file_path, power=0):
    """Function to compress PDF via Ghostscript command line interface"""
    quality = {
        0: '/default',
        1: '/prepress',
        2: '/printer',
        3: '/ebook',
        4: '/screen'
    }

    # Basic controls
    # Check if valid path
    if not os.path.isfile(input_file_path):
        return False

    # Check if file is a PDF by extension
    if input_file_path.split('.')[-1].lower() != 'pdf':
        return False

    try:
        gs = get_ghostscript_path()
        CREATE_NO_WINDOW = 0x08000000
        # DETACHED_PROCESS = 0x00000008
        subprocess.call([gs, '-sDEVICE=pdfwrite', '-dCompatibilityLevel=1.4',
                        '-dPDFSETTINGS={}'.format(quality[power]),
                        '-dNOPAUSE', '-dQUIET', '-dBATCH',
                        '-sOutputFile={}'.format(output_file_path),
                        input_file_path], creationflags=CREATE_NO_WINDOW
        )
        return True
    except:
        print('error')
        return False
