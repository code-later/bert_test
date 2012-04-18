require 'bertrpc'

class PonyService
  class NotFound < Exception; end

  class <<self
    def find_pony_by_name(name)
      if pony = client.call.pony_service.find_pony_by_name(name)
        return pony
      else
        raise NotFound
      end
    end

    def client
      @client ||= BERTRPC::Service.new('localhost', 8000)
    end
  end

end
