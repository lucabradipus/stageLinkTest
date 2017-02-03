# FB.api(
#   '/249403588440524_1336300486417490',
#   'GET',
#   {"fields":"type,reactions,comments"},
#   function(response) {
#     // Insert your code here
#   }
require 'Koala'
require 'csv'
class FbPost < ActiveRecord::Base

  def self.reactions(access_token, object_id)
    facebook = Koala::Facebook::API.new(access_token)
    facebook.get_object("#{object_id}?fields=type,reactions,comments")
  end


  def self.posts_in_page(access_token, pages, limits)
    graph = Koala::Facebook::API.new(access_token)
    interactions=[]
    pages.size.times do |index|
      page_id = pages[index]
      limit = limits[index]

      raw_data = graph.get_object("#{page_id}?fields=posts.limit(#{limit}){type,reactions.limit(100),comments}")
      raw_data['posts']['data'].each do |p|
        post_type = p["type"]
        post_id = p["id"]
        unless p['reactions'].nil?
          p['reactions']['data'].each do |r|
            user_id = r['id']
            interaction_type = 'reaction'
            interaction_subtype = r['type']
            interactions << [user_id, page_id, post_id, post_type, interaction_type, interaction_subtype]
          end
        end
        unless p['comments'].nil?
          p['comments']['data'].each do |r|
            user_id = r['from']['id']
            interaction_type = 'comment'
            interactions << [user_id, page_id, post_id, post_type, interaction_type]
          end
        end

      end
    end

    interactions

  end

  def self.to_csv(interactions, options = {})
    column_names = %w(user_id page_id post_id post_type interaction_type interaction_subtype)
    CSV.generate do |csv|
      csv << column_names
      interactions.each do |int|
        csv << int
      end
    end
  end

end
