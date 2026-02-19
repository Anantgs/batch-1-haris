const http = require("http");

const PORT = 3000;

const server = http.createServer((req, res) => {
  const timestamp = new Date().toISOString();

  // Log incoming request
  console.log(
    `[${timestamp}] ${req.method} ${req.url} from ${req.socket.remoteAddress}`
  );

  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Hello from ECS 🚀\n");
});

server.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});

