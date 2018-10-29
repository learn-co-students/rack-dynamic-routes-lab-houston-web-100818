require_relative 'item'
require 'pry'

class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_to_find = req.path.split("/items/").last
      item_to_search = @@items.find do | item |
        item.name == item_to_find
      end

      if item_to_search
        resp.write item_to_search.price
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
