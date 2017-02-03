# FB.api(
#   '/249403588440524_1336300486417490',
#   'GET',
#   {"fields":"type,reactions,comments"},
#   function(response) {
#     // Insert your code here
#   }
require 'Koala'
class FbPost < ActiveRecord::Base

  def self.reactions(access_token, object_id)
    facebook = Koala::Facebook::API.new(access_token)
    facebook.get_object("#{object_id}?fields=type,reactions,comments")
  end

  def self.posts_in_page(access_token, page_id, limit)
    graph = Koala::Facebook::API.new(access_token)
    interactions = graph.get_object("#{page_id}?fields=posts.limit(#{limit}){type,reactions.limit(100),comments}")
    # interactions = posts.map do |p|
    #   graph.get_object("#{p['id']}?fields=type,reactions.limit(100),comments")['reactions']['data']
    #
    # end
    # interactions =  graph.get_object("#{posts[0]['id']},#{posts[1]['id']}?fields=type,reactions.limit(100),comments")['reactions']['data']
    interactions
  end

  end
