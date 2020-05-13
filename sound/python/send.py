import time
import requests

# play one chromatic octave
for i in range(60, 71):
    requests.get("http://216.180.89.221:12345/?type=noteOn&channel=1&noteNumber=%d&value=90" % i)
    time.sleep(0.2)
