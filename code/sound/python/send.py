# import Python modules
import time
import requests

# play one chromatic octave
for i in range(60, 71):
  note = str(i)
  url = "http://localhost:9000/?type=noteOn&channel=2&number=" + note + "&value=90"
  requests.get(url)
  # time between each note
  time.sleep(0.2)

# value 0 to mute
requests.get("http://localhost:9000/?type=noteOn&channel=2&number=0&value=0")
