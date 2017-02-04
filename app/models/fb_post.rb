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



  def self.posts_in_page(access_token, pages, limits)
    graph = Koala::Facebook::API.new(access_token)
    interactions=[]
    pages.size.times do |index|
      page_id = pages[index]
      raw_data = graph.get_object("#{page_id}?fields=posts.limit(#{limits[index]}){type,reactions.limit(100),comments.limit(100)}")
      raw_data['posts']['data'].each do |p|
        post_type = p["type"]
        post_id = p['id']
        unless p['reactions'].nil?
          interactions = p['reactions']['data'].map do |r|
            [r['id'], page_id, post_id, post_type, 'reaction', r['type']]
          end
        end
        unless p['comments'].nil?
          interactions += p['comments']['data'].map do |r|
            [r['from']['id'], page_id, post_id, post_type, 'comment']
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
