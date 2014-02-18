require 'socket'

server = TCPServer.new 1337 #Server bound to port 1337

loop do
  client = server.accept #Wait for a client to connect
  request = client.gets
  verb, path, header = request.split(' ')

  path = File.join("public", path)

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html" 
  #client.puts "Content-Length: " + body.bytesize.to_s
  client.puts "Connection: close"
  client.puts

  File.open(path, "r") do |file|
    client.puts file.read
  end 

  client.close
end