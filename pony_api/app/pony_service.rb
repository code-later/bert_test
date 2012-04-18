class PonyService
  class NotFound < Exception; end

  class <<self
    def find_pony_by_name(name)
      if name == "Applejack"
        { name: "Applejack", type: "Earthpony" }
      else
        raise NotFound
      end
    end
  end

end
