require 'rubygems'
require 'bundler/setup'

require 'ernie'
require 'nokogiri'
require 'open-uri'

module PonyServiceImpl

  def find_pony_by_name(name)
    doc = Nokogiri::HTML.parse(open("http://en.wikipedia.org/wiki/List_of_My_Little_Pony:_Friendship_Is_Magic_characters"))

    if data = doc.at_xpath("//h3/span[@id='#{name}']/../following-sibling::p[position()=1]")
      { name: "Applejack", description: data.content }
    else
      nil
    end
  end

end

Ernie.expose(:pony_service, PonyServiceImpl)
