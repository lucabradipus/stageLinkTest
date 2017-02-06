require 'Koala'
require 'csv'
class FbPost
  include ActiveModel::Validations
  attr_accessor :pages, :access_token

  COLUMNS_NAMES = %w(user_id page_id post_id post_type interaction_type interaction_subtype)
  validates_presence_of :access_token, :message => "Please, login to Facebook"
  validates_presence_of :pages

  def initialize(pages,access_token)
    self.pages = []
    pages.each do |page|
      self.pages << PageQuery.new(page['id'],page['limit'].to_i,access_token)
    end
    self.access_token = access_token
  end

  def get_interactions
    graph = Koala::Facebook::API.new(self.access_token)

    interactions=[]
    #TODO the limit to post and reaction must be verified
    self.pages.each do |page|
      interactions += page.reactions_in_page(graph)
    end
    interactions

  end

  def to_csv
    interactions = self.get_interactions
    CSV.generate do |csv|
      csv << COLUMNS_NAMES
      interactions.each do |int|
        csv << int
      end
    end
  end

end
