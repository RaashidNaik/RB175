class MyApp
	def call(env)
		['200', { "Content-Type"=> "text/plain" }, ["hello world"] ]
	end
end

class FriendlyGreeting
  def initialize(app)
    @app = app
  end

  def call(env)
    body = @app.call(env).last
    [
      '200',
      { "Content-Type" => "text/plain" },
      body.prepend("A warm welcome to you!\n")
    ]
  end
end

class Wave
  def initialize(app)
    @app = app
  end

  def call(env)
    body = @app.call(env).last
    [
      '200',
      {"Content-Type" => "text/plain" },
      body.prepend("Wave Hello!!!\n")
    ]
  end
end