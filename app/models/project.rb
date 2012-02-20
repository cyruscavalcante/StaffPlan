class Project < ActiveRecord::Base
  
  belongs_to  :client
  belongs_to  :company
  has_many :work_weeks, :dependent => :destroy do
    def for_user(user)
      self.select { |ww| ww.user == user }
    end
  end
  
  has_and_belongs_to_many :users, uniq: true
  
  validates_presence_of :name, :client
  
  default_scope(order: "client_id ASC, name ASC")
end
