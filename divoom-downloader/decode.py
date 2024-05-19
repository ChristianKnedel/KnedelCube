from apixoo.pixel_bean import PixelBean
from apixoo.pixel_bean_decoder import PixelBeanDecoder
from struct import unpack
import sys
 
PixelBeanDecoder.decode_file( sys.argv[1] ).save_to_gif( sys.argv[1] + ".gif" )