module UserFilter
  extend ActiveSupport::Concern

  include do
    attr_reader :user
    before_filter :sort_user
  end
  def sort_user

  end
end
