require "socket"

server = TCPServer.new("localhost", 8080)

loop do
	client = server.accept

	client.puts "HTTP/1.1 200 OK"
	client.puts "Content-Type: text/html\r\n"
	client.puts
	client.puts "<html>"
	client.puts "<body>"
	client.puts "Hello"
	client.puts "</body>"
	client.puts "<html>"
	client.close
end