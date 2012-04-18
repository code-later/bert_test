require 'sinatra/base'
require 'json'
require 'app/pony_service'

class PonyApi < Sinatra::Base

  before do
    content_type 'application/json'
  end

  get "/ponies/:name" do
    name = params[:name]

    begin
      pony = PonyService.find_pony_by_name(name)

      status 200
      body pony.to_json
    rescue PonyService::NotFound => e
      logger.info "We could not find a pony with the name '#{name}'"
      status 404
      body({message: "Pony '#{name}' not found!"}.to_json)
    end
  end

end
