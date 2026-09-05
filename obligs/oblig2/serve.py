"""
Simple static file server — opens main.pdf
Opens http://localhost:7000/viewer.html
"""
import http.server, os, webbrowser, threading

PORT = 7000

class Handler(http.server.SimpleHTTPRequestHandler):
    def log_message(self, *args): pass

os.chdir(os.path.dirname(os.path.abspath(__file__)))

server = http.server.HTTPServer(('localhost', PORT), Handler)
url = f'http://localhost:{PORT}/viewer.html'
print(f'  typst viewer → {url}')
print(f'  Ctrl+C to stop\n')
threading.Timer(0.5, lambda: webbrowser.open(url)).start()
server.serve_forever()