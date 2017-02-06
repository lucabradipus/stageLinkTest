require 'koala'
require 'csv'
class PageQuery
  include ActiveModel::Validations
  attr_accessor :page_id, :limit, :access_token

  #TODO INTERACTION_LIMIT -the limit to comments and reactions- must be verified
  INTERACTION_LIMIT = 100
  validates_presence_of :access_token, :message => "Please, login to Facebook"
  validates_presence_of :page_id, :message => "Please, insert a Facebook page ID!"
  validates_presence_of :limit, :message => "Please, insert a limit"
  validates_format_of :page_id, :with => /\A[_A-z0-9]{1,}\z/
  validates :limit, numericality: { only_integer: true, greater_than: 0, less_than: 101}


  def initialize(id, limit, access_token)
    self.page_id = id
    self.limit = limit
    self.access_token = access_token
 end


  def reactions_in_page(graph = nil)
    graph ||= Koala::Facebook::API.new(self.access_token)
    interactions=[]
      raw_data = graph.get_object("#{self.page_id}?fields=posts.limit(#{self.limit}){type,reactions.limit(#{INTERACTION_LIMIT}),comments.limit(#{INTERACTION_LIMIT})}")
      raw_data['posts']['data'].each do |p|
        post_type = p["type"]
        post_id = p['id']
        unless p['reactions'].nil?
          interactions += p['reactions']['data'].map do |r|
            [r['id'], self.page_id, post_id, post_type, 'reaction', r['type']]
          end
        end
        unless p['comments'].nil?
          interactions += p['comments']['data'].map do |r|
            [r['from']['id'], self.page_id, post_id, post_type, 'comment']
          end
        end
      end
    interactions
  end

end
