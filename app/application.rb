require 'pry'
class Application
  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match("/items/")
      binding.pry
      item = req.path.split("/").last
      if Item.items.find{|t| t.name == item}
        binding.pry
        price = Item.items.find{|t| t.name == item}.price
        resp.write price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end
