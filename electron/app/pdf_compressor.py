
import subprocess
import os.path
import sys
import shutil

def get_ghostscript_path():
    prgmPath = ""
    if os.environ.get("PROGRAMFILES(X86)") is None: #this case is 32bit 
        prgmPath = os.environ.get("PROGRAMFILES")
    else:
        prgmPath = os.environ.get("PROGRAMFILES(X86)")
    print(prgmPath)
    pathName = "E9pay\\E9pass Manager\\resources\\app\\dist-python\\bin\\gswin32c.exe"
    gostPath = os.path.join(prgmPath, pathName)
    print(gostPath)
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

    # try:
    gs = get_ghostscript_path()
    subprocess.call([gs, '-sDEVICE=pdfwrite', '-dCompatibilityLevel=1.4',
                    '-dPDFSETTINGS={}'.format(quality[power]),
                    '-dNOPAUSE', '-dQUIET', '-dBATCH',
                    '-sOutputFile={}'.format(output_file_path),
                    input_file_path]
    )
    return True
    # except:
    #     print('error')
    #     return False
    


source = "C:\\Users\\E9pay Vidusha\\Desktop\\E9pass\\PDF\\7309147451946-200627-3987-5532.pdf"
dist = "C:\\Users\\E9pay Vidusha\\Desktop\\E9pass\\7309147451946-200627-3987-5532.pdf"

compress(source, dist, power=2)